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
    public let ratings: (int: Int, decimal: CGFloat)
    public let numberOfRatingsText: String
    
    public init(title: String, seller: String, ratings: (int: Int, decimal: CGFloat), numberOfRatingsText: String) {
        self.title = title
        self.seller = seller
        self.ratings = ratings
        self.numberOfRatingsText = numberOfRatingsText
    }
}
