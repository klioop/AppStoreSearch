//
//  AppStoreRecentSearchTermViewModel.swift
//  AppStoreSearchiOS
//
//  Created by Lee Sam on 2023/09/16.
//

import Foundation

public struct AppStoreRecentSearchTermViewModel {
    public let isMatchedRecent: Bool
    public let term: String
    
    public init(isMatchedRecent: Bool = false, term: String) {
        self.isMatchedRecent = isMatchedRecent
        self.term = term
    }
}
