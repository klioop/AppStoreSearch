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
        store.insert(term, completion: completion)
    }
}
