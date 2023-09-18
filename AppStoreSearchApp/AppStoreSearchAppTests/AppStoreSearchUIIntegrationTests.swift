//
//  AppStoreSearchUIIntegrationTests.swift
//  AppStoreSearchUIIntegrationTests
//
//  Created by Lee Sam on 2023/09/18.
//

import XCTest
import AppStoreSearch
import AppStoreSearchiOS
import AppStoreSearchApp

final class AppStoreSearchUI {
    private init() {}
    
    static func composedWith() -> AppStoreSearchContainerViewController {
        let searchViewController = AppStoreSearchViewController(viewModel: AppStoreSearchPresenter.viewModel())
        let listViewController = ListViewController()
        let container = AppStoreSearchContainerViewController(
            searchView: searchViewController.view(),
            listViewController: listViewController
        )
        return container
    }
}

final class AppStoreSearchUIIntegrationTests: XCTestCase {
    
    func test_() {
        let sut = AppStoreSearchUI.composedWith()
        let list = sut.listViewController
        
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(list?.tableView.numberOfSections, 0)
    }
}
