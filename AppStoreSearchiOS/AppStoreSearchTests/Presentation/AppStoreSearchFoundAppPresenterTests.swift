//
//  AppStoreSearchFoundAppPresenterTests.swift
//  AppStoreSearchTests
//
//  Created by Lee Sam on 2023/09/19.
//

import XCTest
import AppStoreSearch

extension Double {
    var formatted: String {
        switch self {
        case ..<1_000:
            return String(Int(self))
            
        case 1_000 ..< 10_000:
            return String(format: "%.1f천", locale: Locale.current, self / 1_000)
            
        default:
            return String(format: "%.1f만", locale: Locale.current, self / 10_000)
        }
    }
}

public final class AppStoreSearchFoundAppPresenter {
    
    public static func map(_ app: App) -> AppStoreSearchResultViewModel {
        return AppStoreSearchResultViewModel(
            title: app.title,
            seller: app.seller,
            ratings: map(app.rating),
            numberOfRatingsText: Double(app.numberOfRatings).formatted,
            logoImage: app.logo
        )
    }
    
    // MARK: - Helpers
    
    private static func map(_ rating: Double) -> (int: Int, decimal: CGFloat) {
        let int = Int(rating)
        let decimal = rating.truncatingRemainder(dividingBy: Double(int))
        return (int, decimal)
    }
}

final class AppStoreSearchFoundAppPresenterTests: XCTestCase {
    
    func test_map_AppStoreSearchResultViewModel() {
        let app = makeAnyApp()
        let viewModel = AppStoreSearchFoundAppPresenter.map(app)
        let formattedNumberOfRatings = Double(app.numberOfRatings).formatted
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
