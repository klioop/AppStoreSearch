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
        let store = SearchTermStoreSpy()
        let sut = LocalSearchTermLoader(store: store)
        
        XCTAssertTrue(store.receivedMessages.isEmpty)
    }
    
    func test_save_sendInsertionMessageToStore() {
        let store = SearchTermStoreSpy()
        let sut = LocalSearchTermLoader(store: store)
        let term = LocalSearchTerm(term: "a term")
        
        sut.save(term) {_ in }
        store.completeInsertion()
        
        XCTAssertEqual(store.receivedMessages, [.insert(term)])
    }
    
    // MARK: - Helpers
    
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
