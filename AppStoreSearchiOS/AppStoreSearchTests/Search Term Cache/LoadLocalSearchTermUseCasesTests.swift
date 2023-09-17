//
//  LoadLocalSearchTermUseCasesTests.swift
//  AppStoreSearchTests
//
//  Created by Lee Sam on 2023/09/17.
//

import XCTest
import AppStoreSearch

class LoadLocalSearchTermUseCasesTests: XCTestCase {
    
    func test_init_DoesNotSendRetrieveMessageToStore() {
        let (_, store) = makeSUT()
        
        XCTAssertTrue(store.receivedMessages.isEmpty)
    }
    
    func test_load_sendRetrieveMessageToStore() {
        let (sut, store) = makeSUT()
        
        sut.load {_ in }
        store.completeRetrieval()
        
        XCTAssertEqual(store.receivedMessages, [.retrieve])
    }
    
    func test_load_deliversErrorOnRetrievalFailure() {
        let (sut, store) = makeSUT()
        let retrievalError = anyError()
        
        expect(sut, toCompletedWith: .failure(retrievalError), when: {
            store.completeRetrieval()
        })
    }
    
    // MARK: - Helpers
    
    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> (sut: LocalSearchTermLoader, store: SearchTermStoreSpy) {
        let store = SearchTermStoreSpy()
        let sut = LocalSearchTermLoader(store: store)
        trackMemoryLeak(store, file: file, line: line)
        trackMemoryLeak(sut, file: file, line: line)
        return (sut, store)
    }
    
    private func expect(_ sut: LocalSearchTermLoader, toCompletedWith expectedResult: Result<[LocalSearchTerm], Error>, when action: () -> Void, file: StaticString = #filePath, line: UInt = #line) {
        let exp = expectation(description: "a wait for load completion")
        
        sut.load { receivedResult in
            switch (receivedResult, expectedResult) {
            case let (.success(receivedTerms), .success(expectedTerms)):
                XCTAssertEqual(receivedTerms, expectedTerms, file: file, line: line)
                
            case let (.failure(receivedError as NSError), .failure(expectedError as NSError)):
                XCTAssertEqual(receivedError, expectedError, file: file, line: line)
                
            default:
                XCTFail("\(expectedResult) 를 기대 했지만, \(receivedResult) 가 나옴", file: file, line: line)
            }
            exp.fulfill()
        }
        
        action()
        wait(for: [exp], timeout: 1.0)
    }
}
