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
        
        XCTAssertEqual(viewModel.title, app.title)
        XCTAssertEqual(viewModel.seller, app.seller)
        XCTAssertEqual(viewModel.numberOfRatingsText, "\(formattedNumberOfRatings)개")
        assertEqual([viewModel.ratings], [convert(app.rating)])
    }
    
    func test_map_AppStoreSearchResultViewModelWithEmptyNumberOfStringsOnZeroRatingCount() {
        let app = makeApp(rating: 0.0, numberOfRating: 0)
        let viewModel = AppStoreAppPresenter.map(app)
        
        XCTAssertEqual(viewModel.numberOfRatingsText, "")
    }
    
    func test_map_AppDescriptionViewModel() {
        let app = makeApp(rating: 4.333, numberOfRating: 32454)
        let viewModel = AppStoreAppPresenter.mapToDescription(app)
        let formattedNumberOfRatings = Double(app.numberOfRatings).formattedText
        
        XCTAssertEqual(viewModel.genre, app.genre)
        XCTAssertEqual(viewModel.genreDescription, "장르")
        XCTAssertEqual(viewModel.ageText, app.age)
        XCTAssertEqual(viewModel.ageDescription, "연령")
        XCTAssertEqual(viewModel.ratingText, convert(app.rating))
        XCTAssertEqual(viewModel.numberOfRatingText, "\(formattedNumberOfRatings)개의 평가")
    }
    
    // MARK: - Helpers
    
    private func convert(_ rating: Double) -> (Int, CGFloat) {
        let formatted = String(format: "%.2f", rating)
        let separated = formatted.components(separatedBy: ".")
        let intPart = Int(rating)
        
        guard separated.count == 2 else { return (intPart, 0.0)}
        
        let decimal = (Double(separated[1]) ?? 0.0) / 100
        return (intPart, decimal)
    }
    
    private func convert(_ rating: Double) -> String {
        let formatted = String(format: "%.1f", rating)
        let separated = formatted.components(separatedBy: ".")
        
        guard separated.count == 2 else { return "\(Int(rating))"}
        
        return formatted
    }
    
    private func assertEqual(_ rating1: [(Int, CGFloat)],  _ rating2: [(Int, CGFloat)], file: StaticString = #filePath, line: UInt = #line) {
        XCTAssertTrue(
            rating1.elementsEqual(rating2, by: ==),
            "\(rating1) 는 \(rating2) 와 같지 않다",
            file: file,
            line: line
        )
    }
}
