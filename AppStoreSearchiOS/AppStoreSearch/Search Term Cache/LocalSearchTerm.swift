//
//  LocalSearchTerm.swift
//  AppStoreSearch
//
//  Created by Lee Sam on 2023/09/17.
//

import Foundation

public struct LocalSearchTerm: Equatable {
    public let term: String
    
    public init(term: String) {
        self.term = term
    }
}
