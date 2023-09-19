//
//  AppStoreSearchFoundAppPresenterTests.swift
//  AppStoreSearchTests
//
//  Created by Lee Sam on 2023/09/19.
//

import XCTest
@testable import AppStoreSearch

final class AppStoreSearchFoundAppPresenterTests: XCTestCase {
    
    func test_map_AppStoreSearchResultViewModel() {
        let app = makeAnyApp()
        let viewModel = AppStoreSearchFoundAppPresenter.map(app)
        let formattedNumberOfRatings = Double(app.numberOfRatings).formattedText
        let convertedRating = convert(app.rating)
        
        XCTAssertEqual(app.title, viewModel.title)
        XCTAssertEqual(app.seller, viewModel.seller)
        XCTAssertEqual(convertedRating.int, viewModel.ratings.int)
        XCTAssertEqual(convertedRating.decimal, viewModel.ratings.decimal)
        XCTAssertEqual(formattedNumberOfRatings, viewModel.numberOfRatingsText)
        XCTAssertEqual(app.logo, viewModel.logoImage)
    }
    
    // MARK: - Helpers
    
    private func convert(_ rating: Double) -> (int: Int, decimal: CGFloat) {
        let int = Int(rating)
        let decimal = rating.truncatingRemainder(dividingBy: Double(int))
        return (int, decimal)
    }
    
    private func makeAnyApp() -> App {
        App(
            id: AppID(id: 0),
            title: "a title",
            seller: "a seller",
            rating: 4.8888,
            numberOfRatings: 654,
            version: "x.xx.x",
            currentReleaseDate: Date(),
            releaseNotes: "a release note",
            genre: "a genre",
            age: "a age",
            logo: anyURL(),
            images: [anyURL()]
        )
    }
    
    private func anyURL() -> URL {
        URL(string: "http://any-url.com")!
    }
}