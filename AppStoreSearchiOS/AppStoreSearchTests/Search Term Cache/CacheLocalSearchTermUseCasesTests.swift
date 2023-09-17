//
//  CacheLocalSearchTermUseCasesTests.swift
//  AppStoreSearchTests
//
//  Created by Lee Sam on 2023/09/17.
//

import XCTest
import AppStoreSearch

class CacheLocalSearchTermUseCasesTests: XCTestCase {
    
    func test_init_doesNotSendAnyMessagesToStore() {
        let (_, store) = makeSUT()
        
        XCTAssertTrue(store.receivedMessages.isEmpty)
    }
    
    func test_save_sendInsertMessageToStore() {
        let (sut, store) = makeSUT()
        let term = makeLocalTerm()
        
        sut.save(term) {_ in }
        store.completeInsertion()
        
        XCTAssertEqual(store.receivedMessages, [.insert(term)])
    }
    
    func test_save_failsOnInsertionError() {
        let (sut, store) = makeSUT()
        let insertionError = anyError()
        
        expect(sut, toCompletedWith: insertionError, when: {
            store.completeInsertion(with: insertionError)
        })
    }
    
    func test_save_successOnSuccessfulInsertion() {
        let (sut, store) = makeSUT()
        
        expect(sut, toCompletedWith: .none, when: {
            store.completeInsertionSuccessfully()
        })
    }
    
    func test_save_doesNotDeliverInsertionError_afterSUTInstanceHasBeenDeallocated() {
        let store = SearchTermStoreSpy()
        var sut: LocalSearchTermLoader? = LocalSearchTermLoader(store: store)
        
        var receivedResults = [Result<Void, Error>]()
        sut?.save(makeLocalTerm()) { receivedResults.append($0) }
        sut = nil
        store.completeInsertion()
        
        XCTAssertTrue(receivedResults.isEmpty)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> (sut: LocalSearchTermLoader, store: SearchTermStoreSpy) {
        let store = SearchTermStoreSpy()
        let sut = LocalSearchTermLoader(store: store)
        trackMemoryLeak(store, file: file, line: line)
        trackMemoryLeak(sut, file: file, line: line)
        return (sut, store)
    }
    
    private func expect(_ sut: LocalSearchTermLoader, toCompletedWith expectedError: NSError?, when action: () -> Void, file: StaticString = #filePath, line: UInt = #line) {
        let exp = expectation(description: "a wait for save completion")
        
        var receivedError: Error?
        sut.save(makeLocalTerm()) { result in
            if case let .failure(error) = result {
                receivedError = error
            }
            exp.fulfill()
        }
        
        action()
        
        wait(for: [exp], timeout: 1.0)
        
        XCTAssertEqual(receivedError as NSError? , expectedError)
    }
    
    private func makeLocalTerm(term: String = "a term") -> LocalSearchTerm {
        LocalSearchTerm(term: term)
    }
    
    private func anyError() -> NSError {
        NSError(domain: "a error", code: 0)
    }
    
    final class SearchTermStoreSpy: SearchTermStore {
        private(set) var receivedMessages: [Message] = []
        
        private var insertionCompletions: [(InsertionResult) -> Void] = []
        
        enum Message: Equatable {
            case insert(_ term: LocalSearchTerm)
        }
        
        func insert(_ term: LocalSearchTerm, completion: @escaping (InsertionResult) -> Void) {
            receivedMessages.append(.insert(term))
            insertionCompletions.append(completion)
        }
        
        func completeInsertion(with error: Error = NSError(domain: "a error", code: 0), at index: Int = 0) {
            insertionCompletions[index](.failure(error))
        }
        
        func completeInsertionSuccessfully(at index: Int = 0) {
            insertionCompletions[index](.success(()))
        }
    }
}

extension XCTestCase {
    func trackMemoryLeak(_ instance: AnyObject, file: StaticString, line: UInt) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(
                instance,
                "테스트가 끝난 후 객체는 메모리에서 해제되어야 한다. 이 에러는 메모리 릭을 암시",
                file: file,
                line:  line
            )
        }
    }
}
