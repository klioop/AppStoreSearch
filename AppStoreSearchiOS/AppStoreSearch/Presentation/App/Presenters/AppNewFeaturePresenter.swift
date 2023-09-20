//
//  AppNewFeaturePresenter.swift
//  AppStoreSearch
//
//  Created by Lee Sam on 2023/09/20.
//

import Foundation

public final class AppNewFeaturePresenter {
    private init() {}
    
    public static func map(_ app: App, currentDate: Date = Date(), calendar: Calendar = .current, locale: Locale = .current) -> AppNewFeatureViewModel {
        let descriptions = descriptions(from: app.releaseNotes)
        return AppNewFeatureViewModel(
            title: "새로운 기능",
            version: app.version,
            releaseDateTitle: "버전 기록",
            currentReleaseDate: text(
                for: app.currentReleaseDate,
                relativeTo: currentDate,
                calendar: calendar,
                locale: locale
            ),
            firstDescription: descriptions.first,
            secondDescription: descriptions.second
        )
    }
    
    // MARK: - Helpers
    
    private static func text(for givenDate: Date, relativeTo date: Date, calendar: Calendar, locale: Locale) -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.calendar = calendar
        formatter.locale = locale
        return formatter.localizedString(for: givenDate, relativeTo: date)
    }
    
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
