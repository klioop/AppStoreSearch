//
//  AppStoreSearchPresenterTests.swift
//  AppStoreSearchTests
//
//  Created by Lee Sam on 2023/09/18.
//

import XCTest
import AppStoreSearch

final class AppStoreSearchPresenterTests: XCTestCase {

    func test_makeViewModel() {
        let viewModel = AppStoreSearchPresenter.viewModel()
        XCTAssertEqual(viewModel.title, "검색")
        XCTAssertEqual(viewModel.placeholder, "게임, 앱, 스토리 등")
    }

}
