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
        let now = Date()
        var calendar = Calendar(identifier: .gregorian)
        let locale = Locale(identifier: "en-US")
        let app = makeApp(
            version: "1.23.4",
            notes: "first\nsecond\nthird\nfirth",
            releaseDate: now.adding(days: -5)
        )
        let viewModel = AppNewFeaturePresenter.map(app, currentDate: now, calendar: calendar, locale: locale)
        
        XCTAssertEqual(viewModel.title, "새로운 기능")
        XCTAssertEqual(viewModel.version, app.version)
        XCTAssertEqual(viewModel.currentReleaseDate, "5 days ago")
        XCTAssertFalse(viewModel.firstDescription.isEmpty)
        XCTAssertFalse(viewModel.secondDescription.isEmpty)
    }
    
    func test_map_AppNewFeatureViewModelWithEmptySecondDescriptionsOnShortNotes() {
        let now = Date()
        var calendar = Calendar(identifier: .gregorian)
        let locale = Locale(identifier: "en-US")
        let app = makeApp(
            version: "1.23.4",
            notes: "first\nsecond",
            releaseDate: now.adding(days: -10)
        )
        let viewModel = AppNewFeaturePresenter.map(app, currentDate: now, calendar: calendar, locale: locale)
        
        XCTAssertEqual(viewModel.title, "새로운 기능")
        XCTAssertEqual(viewModel.version, app.version)
        XCTAssertEqual(viewModel.currentReleaseDate, "1 week ago")
        XCTAssertFalse(viewModel.firstDescription.isEmpty)
        XCTAssertTrue(viewModel.secondDescription.isEmpty)
    }
}

private extension Date {
    func adding(days: Int, calendar: Calendar = .init(identifier: .gregorian)) -> Date {
        calendar.date(byAdding: .day, value: days, to: self)!
    }
}
