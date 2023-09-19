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
            numberOfRatingsText: Double(app.numberOfRatings).formattedText,
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
