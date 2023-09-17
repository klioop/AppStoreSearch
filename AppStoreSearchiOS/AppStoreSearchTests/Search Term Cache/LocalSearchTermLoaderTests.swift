//
//  LocalSearchTermLoaderTests.swift
//  AppStoreSearchTests
//
//  Created by Lee Sam on 2023/09/17.
//

import XCTest
import AppStoreSearch

protocol SearchTermStore {
    typealias InsertionResult = Result<Void, Error>
    
    func insert(_ term: LocalSearchTerm, completion: @escaping (InsertionResult) -> Void)
}

final class LocalSearchTermLoader {
    private let store: SearchTermStore
    
    init(store: SearchTermStore) {
        self.store = store
    }
    
    func save(_ term: LocalSearchTerm, completion: @escaping (Result<Void, Error>) -> Void) {
        store.insert(term) {_ in }
    }
}

class LocalSearchTermLoaderTests: XCTestCase {
    
    func test_init_doesNotSendAnyMessagesToStore() {
        let (_, store) = makeSUT()
        
        XCTAssertTrue(store.receivedMessages.isEmpty)
    }
    
    func test_save_sendInsertionMessageToStore() {
        let (sut, store) = makeSUT()
        let term = LocalSearchTerm(term: "a term")
        
        sut.save(term) {_ in }
        store.completeInsertion()
        
        XCTAssertEqual(store.receivedMessages, [.insert(term)])
    }
    
    // MARK: - Helpers
    
    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> (sut: LocalSearchTermLoader, store: SearchTermStoreSpy) {
        let store = SearchTermStoreSpy()
        let sut = LocalSearchTermLoader(store: store)
        trackMemoryLeak(store, file: file, line: line)
        trackMemoryLeak(sut, file: file, line: line)
        return (sut, store)
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
