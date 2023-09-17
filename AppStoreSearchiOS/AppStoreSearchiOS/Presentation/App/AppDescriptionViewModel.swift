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
    public let rankingText: String
    public let rankDescription: String
    public let ageText: String
    public let ageDescription: String
    
    public init(ratingText: String, numberOfRatingText: String, rating: (int: Int, decimal: Double), rankingText: String, rankDescription: String, ageText: String, ageDescription: String) {
        self.ratingText = ratingText
        self.numberOfRatingText = numberOfRatingText
        self.rating = rating
        self.rankingText = rankingText
        self.rankDescription = rankDescription
        self.ageText = ageText
        self.ageDescription = ageDescription
    }
}
