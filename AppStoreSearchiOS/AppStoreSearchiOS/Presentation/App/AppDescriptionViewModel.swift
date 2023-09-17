//
//  AppDescriptionViewModel.swift
//  AppStoreSearchiOS
//
//  Created by Lee Sam on 2023/09/17.
//

import Foundation

public struct AppDescriptionViewModel {
    public let ratingText: String
    public let numberOfRatingText: String
    public let rating: (int: Int, decimal: Double)
    
    public init(ratingText: String, numberOfRatingText: String, rating: (int: Int, decimal: Double)) {
        self.ratingText = ratingText
        self.numberOfRatingText = numberOfRatingText
        self.rating = rating
    }
}
