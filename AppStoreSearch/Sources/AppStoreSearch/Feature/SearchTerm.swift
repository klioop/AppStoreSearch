//
//  SearchTerm.swift
//  AppStoreSearch
//
//  Created by Lee Sam on 2023/09/18.
//

import Foundation

public struct SearchTerm: Equatable, Hashable {
    public let term: String
    
    public init(term: String) {
        self.term = term
    }
}
