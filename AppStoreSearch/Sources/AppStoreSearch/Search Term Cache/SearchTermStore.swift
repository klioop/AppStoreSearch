//
//  SearchTermStore.swift
//  AppStoreSearch
//
//  Created by Lee Sam on 2023/09/17.
//

import Foundation

public protocol SearchTermStore {
    typealias InsertionResult = Result<Void, Error>
    typealias RetrievalResult = Result<[LocalSearchTerm], Error>
    
    func insert(_ term: LocalSearchTerm, completion: @escaping (InsertionResult) -> Void)
    func retrieve(completion: @escaping (RetrievalResult) -> Void)
}
