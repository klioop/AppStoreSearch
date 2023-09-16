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
        let container = AppStoreSearchContainerViewController(searchView: searchView)
        
        record(container.snapshot(for: .iPhone11(style: .light)), named: "APPSTORE_SEARCH_light")
    }
}
