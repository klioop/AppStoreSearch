//
//  AppStoreAppPresenterTests.swift
//  AppStoreSearchTests
//
//  Created by Lee Sam on 2023/09/19.
//

import XCTest
@testable import AppStoreSearch

final class AppStoreAppPresenterTests: XCTestCase {
    
    func test_map_AppStoreSearchResultViewModel() {
        let app = makeApp(rating: 4.888, numberOfRating: 644)
        let viewModel = AppStoreAppPresenter.map(app)
        let formattedNumberOfRatings = Double(app.numberOfRatings).formattedText
        
        XCTAssertEqual(app.title, viewModel.title)
        XCTAssertEqual(app.seller, viewModel.seller)
        XCTAssertEqual("평점: " + convert(app.rating), viewModel.ratingText)
        XCTAssertEqual("\(formattedNumberOfRatings)개", viewModel.numberOfRatingsText)
    }
    
    func test_map_AppStoreSearchResultViewModelWithEmptyNumberOfStringsOnZeroRatingCount() {
        let app = makeApp(rating: 0.0, numberOfRating: 0)
        let viewModel = AppStoreAppPresenter.map(app)
        
        XCTAssertEqual("", viewModel.numberOfRatingsText)
    }
    
    func test_map_AppDescriptionViewModel() {
        let app = makeApp(rating: 4.333, numberOfRating: 32454)
        let viewModel = AppStoreAppPresenter.mapToDescription(app)
        let formattedNumberOfRatings = Double(app.numberOfRatings).formattedText
        
        XCTAssertEqual(app.genre, viewModel.genre)
        XCTAssertEqual("장르", viewModel.genreDescription)
        XCTAssertEqual(app.age, viewModel.ageText)
        XCTAssertEqual("연령", viewModel.ageDescription)
        XCTAssertEqual(convert(app.rating), viewModel.ratingText)
        XCTAssertEqual("\(formattedNumberOfRatings)개의 평가", viewModel.numberOfRatingText)
    }
    
    // MARK: - Helpers
    
    private func convert(_ rating: Double) -> String {
        let formatted = String(format: "%.1f", rating)
        let separated = formatted.components(separatedBy: ".")
        
        guard separated.count == 2 else { return "\(Int(rating))"}
        return formatted
    }
    
    private func makeApp(rating: Double, numberOfRating: Int) -> App {
        App(
            id: AppID(id: 0),
            title: "a title",
            seller: "a seller",
            rating: rating,
            numberOfRatings: numberOfRating,
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
