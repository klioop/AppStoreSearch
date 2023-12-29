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
    public let rating: (int: Int, decimal: CGFloat)
    public let genre: String
    public let genreDescription: String
    public let ageText: String
    public let ageDescription: String
    
    public init(ratingText: String, numberOfRatingText: String, rating: (int: Int, decimal: CGFloat), genre: String, genreDescription: String, ageText: String, ageDescription: String) {
        self.ratingText = ratingText
        self.numberOfRatingText = numberOfRatingText
        self.rating = rating
        self.genre = genre
        self.genreDescription = genreDescription
        self.ageText = ageText
        self.ageDescription = ageDescription
    }
}
