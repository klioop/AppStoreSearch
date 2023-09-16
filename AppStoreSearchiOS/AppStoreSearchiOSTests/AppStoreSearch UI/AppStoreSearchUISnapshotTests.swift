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
        let titleCellController = AppStoreRecentSearchTitleCellController(viewModel: "a title")
        let termCellController0 = AppStoreRecentSearchTermCellController(viewModel: "a term0")
        let termCellController1 = AppStoreRecentSearchTermCellController(viewModel: "a term1")
        let termCellController2 = AppStoreRecentSearchTermCellController(viewModel: "a term2")
        let list = ListViewController()
        let container = AppStoreSearchContainerViewController(
            searchView: searchView,
            listViewController: list
        )
        let cellControllers = [titleCellController, termCellController0, termCellController1, termCellController2].map(TableCellController.init)
        
        list.display(cellControllers)
        container.loadViewIfNeeded()
        
        record(container.snapshot(for: .iPhone11(style: .light)), named: "APPSTORE_SEARCH_light")
    }
}
