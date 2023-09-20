//
//  TestHelpers.swift
//  AppStoreSearchTests
//
//  Created by Lee Sam on 2023/09/20.
//

import Foundation
import AppStoreSearch

func makeApp(title: String = "a title", seller: String = "a seller", rating: Double = 3.0, numberOfRating: Int = 10) -> App {
    App(
        id: AppID(id: 0),
        title: title,
        seller: seller,
        rating: rating,
        numberOfRatings: numberOfRating,
        version: "x.xx.x",
        currentReleaseDate: Date(),
        releaseNotes: "a release note",
        genre: "a genre",
        age: "a age",
        logo: anyURL(),
        images: [anyURL()]
    )
}

func anyURL() -> URL {
    URL(string: "http://any-url.com")!
}
