//
//  LocalSearchTermLoaderTests.swift
//  AppStoreSearchTests
//
//  Created by Lee Sam on 2023/09/17.
//

import XCTest

protocol SearchTermStore {}

final class LocalSearchTermLoader {
    private let store: SearchTermStore
    
    init(store: SearchTermStore) {
        self.store = store
    }
}

class LocalSearchTermLoaderTests: XCTestCase {
    
    func test_doesNotSendAnyMessagesToStore_onInit() {
        let spy = SearchTermStoreSpy()
        let sut = LocalSearchTermLoader(store: spy)
        
        XCTAssertTrue(spy.messages.isEmpty)
    }
    
    // MARK: - Helpers
    
    final class SearchTermStoreSpy: SearchTermStore {
        private(set) var messages: [Any] = []
    }
}
