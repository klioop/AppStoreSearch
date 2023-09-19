//
//  App.swift
//  AppStoreSearch
//
//  Created by Lee Sam on 2023/09/17.
//

import Foundation

public struct AppID: Hashable {
    public let id: Int
    
    public init(id: Int) {
        self.id = id
    }
}

public struct App {
    public let id: AppID
    public let title: String
    public let seller: String
    public let rating: Double
    public let numberOfRatings: Int
    public let version: String
    public let currentReleaseDate: Date
    public let releaseNotes: String
    public let genre: String
    public let age: String
    public let logo: URL
    public let images: [URL]
    
    public init(id: AppID, title: String, seller: String, rating: Double, numberOfRatings: Int, version: String, currentReleaseDate: Date, releaseNotes: String, genre: String, age: String, logo: URL, images: [URL]) {
        self.id = id
        self.title = title
        self.seller = seller
        self.rating = rating
        self.numberOfRatings = numberOfRatings
        self.version = version
        self.currentReleaseDate = currentReleaseDate
        self.releaseNotes = releaseNotes
        self.genre = genre
        self.age = age
        self.logo = logo
        self.images = images
    }
}

extension App: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
