//
//  AppStoreRecentSearchTermPresenterTests.swift
//  AppStoreSearchTests
//
//  Created by Lee Sam on 2023/09/18.
//

import XCTest
import AppStoreSearch

class AppStoreRecentSearchTermPresenterTests: XCTestCase {
    
    func test_map_searchTermToRecentSearchTermViewModel() {
        let term = "any term"
        let searchTerm = SearchTerm(term: term)
        let viewModel = AppStoreRecentSearchTermPresenter.map(searchTerm)
        
        XCTAssertFalse(viewModel.isMatchedRecent)
        XCTAssertEqual(viewModel.term, term)
    }
}
