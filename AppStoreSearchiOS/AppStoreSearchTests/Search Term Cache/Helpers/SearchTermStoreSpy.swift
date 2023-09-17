//
//  SearchTermStoreSpy.swift
//  AppStoreSearchTests
//
//  Created by Lee Sam on 2023/09/17.
//

import Foundation
import AppStoreSearch

final class SearchTermStoreSpy: SearchTermStore {
    private(set) var receivedMessages: [Message] = []
    
    private var insertionCompletions: [(InsertionResult) -> Void] = []
    
    enum Message: Equatable {
        case insert(_ term: LocalSearchTerm)
        case retrieve
    }
    
    func insert(_ term: LocalSearchTerm, completion: @escaping (InsertionResult) -> Void) {
        receivedMessages.append(.insert(term))
        insertionCompletions.append(completion)
    }
    
    func retrieve(completion: @escaping (RetrievalResult) -> Void) {
    }
    
    func completeInsertion(with error: Error = NSError(domain: "a error", code: 0), at index: Int = 0) {
        insertionCompletions[index](.failure(error))
    }
    
    func completeInsertionSuccessfully(at index: Int = 0) {
        insertionCompletions[index](.success(()))
    }
}
