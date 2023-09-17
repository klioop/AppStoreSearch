//
//  LoadLocalSearchTermUseCasesTests.swift
//  AppStoreSearchTests
//
//  Created by Lee Sam on 2023/09/17.
//

import XCTest
import AppStoreSearch

class LoadLocalSearchTermUseCasesTests: XCTestCase {
    
    func test_initDoesNotSendRetrieveMessageToStore() {
        let (_, store) = makeSUT()
        
        XCTAssertTrue(store.receivedMessages.isEmpty)
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
