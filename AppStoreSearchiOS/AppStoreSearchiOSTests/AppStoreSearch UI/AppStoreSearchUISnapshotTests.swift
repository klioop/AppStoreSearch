//
//  AppStoreSearchUISnapshotTests.swift
//  AppStoreSearchiOSTests
//
//  Created by Lee Sam on 2023/09/16.
//

import XCTest
import AppStoreSearchiOS

final class AppStoreSearchUISnapshotTests: XCTestCase {
    
    func test_appStoreSearchUI() {
        let searchView = AppStoreSearchView()
        searchView.title = "a title"
        searchView.placeholder = "a placeholder"
        let list = ListViewController()
        let container = AppStoreSearchContainerViewController(
            searchView: searchView,
            listViewController: list
        )
        
        list.display(recentTerms())
        container.loadViewIfNeeded()
        
        record(container.snapshot(for: .iPhone11(style: .light)), named: "APPSTORE_SEARCH_light")
    }
    
    // MARK: - Helpers
    
    private func recentTerms() -> [TableCellController] {
        let titleCellController = AppStoreRecentSearchTitleCellController(viewModel: "a title")
        let termCellController0 = AppStoreRecentSearchTermCellController(viewModel: "a term0")
        let termCellController1 = AppStoreRecentSearchTermCellController(viewModel: "a term1")
        let termCellController2 = AppStoreRecentSearchTermCellController(viewModel: "a term2")
        return [titleCellController, termCellController0, termCellController1, termCellController2].map(TableCellController.init)
    }
}
