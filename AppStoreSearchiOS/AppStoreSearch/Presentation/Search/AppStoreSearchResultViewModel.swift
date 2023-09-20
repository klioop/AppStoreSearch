//
//  AppStoreSearchResultViewModel.swift
//  AppStoreSearchiOS
//
//  Created by Lee Sam on 2023/09/17.
//

import Foundation

public struct AppStoreSearchResultViewModel {
    public let title: String
    public let seller: String
    public let ratingText: String
    public let numberOfRatingsText: String
    
    public init(title: String, seller: String, ratingText: String, numberOfRatingsText: String) {
        self.title = title
        self.seller = seller
        self.ratingText = ratingText
        self.numberOfRatingsText = numberOfRatingsText
    }
}
