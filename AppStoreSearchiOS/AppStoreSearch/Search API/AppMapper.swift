//
//  AppMapper.swift
//  AppStoreSearch
//
//  Created by Lee Sam on 2023/09/17.
//

import Foundation

public final class AppMapper {
    private struct Item: Decodable {
        let trackId: Int
        let trackName: String
        let primaryGenreName: String
        let contentAdvisoryRating: String
        let sellerName: String
        let averageUserRating: Double
        let userRatingCount: Int
        let version: String
        let currentVersionReleaseDate: Date
        let releaseNotes: String
        let artworkUrl512: URL
        let screenshotUrls: [URL]
        
        var model: App {
            App(
                id: AppID(id: trackId),
                title: trackName,
                seller: sellerName,
                rating: averageUserRating,
                numberOfRatings: userRatingCount,
                version: version,
                currentReleaseDate: currentVersionReleaseDate,
                releaseNotes: releaseNotes,
                genre: primaryGenreName,
                age: contentAdvisoryRating,
                logo: artworkUrl512,
                images: screenshotUrls
            )
        }
    }
    
    private init() {}
    
    enum Error: Swift.Error {
        case invalidData
    }
    
    public static func map(_ data: Data, from response: HTTPURLResponse) throws -> [App] {
        guard !data.isEmpty, isOK(response) else { throw Error.invalidData }
        
        do {
            let root = try JSONDecoder().decode([Item].self, from: data)
            return root.map(\.model)
        } catch {
            throw Error.invalidData
        }
    }
    
    // MARK: - Helpers
    
    private static var okCode: Int { 200 }
    
    private static func isOK(_ response: HTTPURLResponse) -> Bool {
        response.statusCode == okCode
    }
}
