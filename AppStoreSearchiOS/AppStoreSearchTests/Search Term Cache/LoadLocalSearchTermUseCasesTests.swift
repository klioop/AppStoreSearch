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
        let exp = expectation(description: "a wait for load completion")
        
        var receivedError: Error?
        sut.load { result in
            if case let .failure(error) = result {
                receivedError = error
            }
            exp.fulfill()
        }
        store.completeRetrieval()
        wait(for: [exp], timeout: 1.0)
        
        XCTAssertNotNil(receivedError)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> (sut: LocalSearchTermLoader, store: SearchTermStoreSpy) {
        let store = SearchTermStoreSpy()
        let sut = LocalSearchTermLoader(store: store)
        trackMemoryLeak(store, file: file, line: line)
        trackMemoryLeak(sut, file: file, line: line)
        return (sut, store)
    }
}
