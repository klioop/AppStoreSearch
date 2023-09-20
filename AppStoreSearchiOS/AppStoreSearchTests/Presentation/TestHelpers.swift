//
//  TestHelpers.swift
//  AppStoreSearchTests
//
//  Created by Lee Sam on 2023/09/20.
//

import Foundation
import AppStoreSearch

func makeApp(title: String = "a title", seller: String = "a seller", rating: Double = 3.0, numberOfRating: Int = 10, version: String = "any version", notes: String = "any notes", releaseDate: Date = Date()) -> App {
    App(
        id: AppID(id: 0),
        title: title,
        seller: seller,
        rating: rating,
        numberOfRatings: numberOfRating,
        version: version,
        currentReleaseDate: releaseDate,
        releaseNotes: notes,
        genre: "a genre",
        age: "a age",
        logo: anyURL(),
        images: [anyURL()]
    )
}

func anyURL() -> URL {
    URL(string: "http://any-url.com")!
}
