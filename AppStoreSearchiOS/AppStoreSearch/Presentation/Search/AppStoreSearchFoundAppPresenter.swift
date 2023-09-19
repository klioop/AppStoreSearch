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
            ratings: map(app.rating),
            numberOfRatingsText: Double(app.numberOfRatings).formattedText
        )
    }
    
    // MARK: - Helpers
    
    private static func map(_ rating: Double) -> (int: Int, decimal: CGFloat) {
        let formatted = String(format: "%.2f", rating)
        let separated = formatted.components(separatedBy: ".")
        let int = (Int(separated[0]) ?? 0)
        
        guard separated.count == 2 else { return (int, 0.0) }
        
        let decimal = (Double(separated[1]) ?? 0.0) / 100
        return (int, decimal)
    }
}
