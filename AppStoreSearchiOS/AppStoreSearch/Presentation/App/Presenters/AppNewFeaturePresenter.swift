//
//  AppNewFeaturePresenter.swift
//  AppStoreSearch
//
//  Created by Lee Sam on 2023/09/20.
//

import Foundation

public final class AppNewFeaturePresenter {
    private init() {}
    
    public static func map(_ app: App) -> AppNewFeatureViewModel {
        let descriptions = descriptions(from: app.releaseNotes)
        return AppNewFeatureViewModel(
            title: "새로운 기능",
            version: app.version,
            firstDescription: descriptions.first,
            secondDescription: descriptions.second
        )
    }
    
    // MARK: - Helpers
    
    private static func descriptions(from note: String) -> (first: String, second: String) {
        let separated = note.components(separatedBy: "\n")
        
        guard separated.count > 2 else {
            return (separated.joined(separator: "\n"), "")
        }
        
        let first = separated[...2].joined(separator: "\n")
        let second = separated[3...].joined(separator: "\n")
        return (first, second)
    }
}
