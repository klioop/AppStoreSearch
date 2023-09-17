//
//  LocalSearchTermLoader.swift
//  AppStoreSearch
//
//  Created by Lee Sam on 2023/09/17.
//

import Foundation

public final class LocalSearchTermLoader {
    private let store: SearchTermStore
    
    public init(store: SearchTermStore) {
        self.store = store
    }
    
    public func save(_ term: LocalSearchTerm, completion: @escaping (Result<Void, Error>) -> Void) {
        store.insert(term) { [weak self] result in
            guard self != nil else { return }
            
            completion(
                Result {
                    switch result {
                    case .success: return
                        
                    case let .failure(error):
                        throw error
                    }
                }
            )
        }
    }
    
    public func load(completion: @escaping (Result<[LocalSearchTerm], Error>) -> Void) {
        store.retrieve { [weak self] result in
            guard self != nil else { return }
            
            completion(
                Result {
                    switch result {
                    case let .success(terms):
                        return terms

                    case let .failure(error):
                        throw error
                    }
                }
            )
        }
    }
}
