//
//  Double+formatted.swift
//  AppStoreSearch
//
//  Created by Lee Sam on 2023/09/19.
//

import Foundation

extension Double {
    var formattedText: String {
        switch self {
        case ..<1_000:
            return String(Int(self))
            
        case 1_000 ..< 10_000:
            return String(format: "%.1f천", locale: Locale.current, self / 1_000)
            
        default:
            return String(format: "%.1f만", locale: Locale.current, self / 10_000)
        }
    }
}
