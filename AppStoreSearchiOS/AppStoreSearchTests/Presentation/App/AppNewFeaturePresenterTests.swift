//
//  AppNewFeaturePresenterTests.swift
//  AppStoreSearchTests
//
//  Created by Lee Sam on 2023/09/20.
//

import XCTest
import AppStoreSearch

class AppNewFeaturePresenterTests: XCTestCase {
    
    func test_map_AppNewFeatureViewModel() {
        let app = makeApp(version: "1.23.4", notes: "first\nsecond\nthird\nfirth")
        let viewModel = AppNewFeaturePresenter.map(app)
        
        XCTAssertEqual("새로운 기능", viewModel.title)
        XCTAssertEqual(app.version, viewModel.version)
        XCTAssertFalse(viewModel.firstDescription.isEmpty)
        XCTAssertFalse(viewModel.secondDescription.isEmpty)
    }
    
    func test_map_AppNewFeatureViewModelWithEmptySecondDescriptionsOnShortNotes() {
        let app = makeApp(version: "1.23.4", notes: "first\nsecond")
        let viewModel = AppNewFeaturePresenter.map(app)
        
        XCTAssertEqual("새로운 기능", viewModel.title)
        XCTAssertEqual(app.version, viewModel.version)
        XCTAssertFalse(viewModel.firstDescription.isEmpty)
        XCTAssertTrue(viewModel.secondDescription.isEmpty)
    }
}

