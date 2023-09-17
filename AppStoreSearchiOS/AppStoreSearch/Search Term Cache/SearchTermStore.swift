//
//  SearchTermStore.swift
//  AppStoreSearch
//
//  Created by Lee Sam on 2023/09/17.
//

import Foundation

public protocol SearchTermStore {
    typealias InsertionResult = Result<Void, Error>
    
    func insert(_ term: LocalSearchTerm, completion: @escaping (InsertionResult) -> Void)
}
