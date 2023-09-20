//
//  TestHelpers.swift
//  AppStoreSearchAppTests
//
//  Created by Lee Sam on 2023/09/20.
//

import Foundation
import AppStoreSearch

func makeApp(id: Int, logo: URL = anyURL(), images: [URL] = [anyURL()]) -> App {
    App(
        id: AppID(id: id),
        title: "a title",
        seller: "a seller",
        rating: 4.8888,
        numberOfRatings: 3,
        version: "x.xx.x",
        currentReleaseDate: Date(),
        releaseNotes: "a release note",
        genre: "a genre",
        age: "a age",
        logo: logo,
        images: images
    )
}

func anyURL() -> URL {
    URL(string: "http://any-url.com")!
}
