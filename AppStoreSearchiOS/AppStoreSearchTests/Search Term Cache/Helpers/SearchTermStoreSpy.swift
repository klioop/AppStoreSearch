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
    private var retrievalCompletions: [(RetrievalResult) -> Void] = []
    
    enum Message: Equatable {
        case insert(_ term: LocalSearchTerm)
        case retrieve
    }
    
    func insert(_ term: LocalSearchTerm, completion: @escaping (InsertionResult) -> Void) {
        receivedMessages.append(.insert(term))
        insertionCompletions.append(completion)
    }
    
    func retrieve(completion: @escaping (RetrievalResult) -> Void) {
        receivedMessages.append(.retrieve)
        retrievalCompletions.append(completion)
    }
    
    func completeInsertion(with error: Error = anyError(), at index: Int = 0) {
        insertionCompletions[index](.failure(error))
    }
    
    func completeInsertionSuccessfully(at index: Int = 0) {
        insertionCompletions[index](.success(()))
    }
    
    func completeRetrieval(with error: Error = anyError(), at index: Int = 0) {
        retrievalCompletions[index](.failure(error))
    }
}
