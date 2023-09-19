//
//  AppStoreSearchFoundAppPresenter.swift
//  AppStoreSearch
//
//  Created by Lee Sam on 2023/09/19.
//

import Foundation

public final class AppStoreSearchFoundAppPresenter {
    
    public static func map(_ app: App) -> AppStoreSearchResultViewModel {
        AppStoreSearchResultViewModel(
            title: app.title,
            seller: app.seller,
            ratings: convert(app.rating),
            numberOfRatingsText: Double(app.numberOfRatings).formattedText
        )
    }
    
    public static func map(_ app: App) -> AppDescriptionViewModel {
        AppDescriptionViewModel(
            ratingText: ratingText(from: app.rating),
            numberOfRatingText: Double(app.numberOfRatings).formattedText + "개의 평가",
            rating: convert(app.rating),
            genre: app.genre,
            genreDescription: "장르",
            ageText: app.age,
            ageDescription: "연령"
        )
    }
    
    // MARK: - Helpers
    
    private static func ratingText(from rating: Double) -> String {
        let formatted = String(format: "%.1f", rating)
        let separated = formatted.components(separatedBy: ".")
        
        guard separated.count == 2 else { return "\(Int(rating))"}
        return formatted
    }
    
    private static func convert(_ rating: Double) -> (int: Int, decimal: CGFloat) {
        let formatted = String(format: "%.2f", rating)
        let separated = formatted.components(separatedBy: ".")
        let int = (Int(separated[0]) ?? 0)
        
        guard separated.count == 2 else { return (int, 0.0) }
        
        let decimal = (Double(separated[1]) ?? 0.0) / 100
        return (int, decimal)
    }
}
