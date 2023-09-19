//
//  AppStoreRecentSearchTermPresenter.swift
//  AppStoreSearch
//
//  Created by Lee Sam on 2023/09/18.
//

import Foundation

public final class AppStoreRecentSearchTermPresenter {
    private init() {}
    
    public static func map(_ term: SearchTerm) -> AppStoreRecentSearchTermViewModel {
        AppStoreRecentSearchTermViewModel(term: term.term)
    }
    
    public static func mapToMatched(_ term: SearchTerm) -> AppStoreRecentSearchTermViewModel {
        AppStoreRecentSearchTermViewModel(
            isMatchedRecent: true,
            term: term.term
        )
    }
}
