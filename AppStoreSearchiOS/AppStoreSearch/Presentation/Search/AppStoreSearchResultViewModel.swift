//
//  AppStoreSearchResultViewModel.swift
//  AppStoreSearchiOS
//
//  Created by Lee Sam on 2023/09/17.
//

import Foundation

public struct AppStoreSearchResultViewModel {
    public let title: String
    public let description: String
    public let ratings: (int: Int, decimal: CGFloat)
    public let numberOfRatingsText: String
    public let logoImage: URL
    public let images: [URL]
    
    public init(title: String, description: String, ratings: (int: Int, decimal: CGFloat), numberOfRatingsText: String, logoImage: URL, images: [URL]) {
        self.title = title
        self.description = description
        self.ratings = ratings
        self.numberOfRatingsText = numberOfRatingsText
        self.logoImage = logoImage
        self.images = images
    }
}
