//
//  AppTitlePresenterTests.swift
//  AppStoreSearchTests
//
//  Created by Lee Sam on 2023/09/20.
//

import XCTest
import AppStoreSearch

class AppTitlePresenterTests: XCTestCase {
    
    func test_map_AppTitleViewModel() {
        let app = makeApp(title: "app title", seller: "app seller")
        let viewModel = AppTitlePresenter.map(app)
        
        XCTAssertEqual(viewModel.title, app.title)
        XCTAssertEqual(viewModel.seller, app.seller)
    }
}
