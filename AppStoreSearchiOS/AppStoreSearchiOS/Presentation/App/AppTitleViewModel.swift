//
//  AppTitleViewModel.swift
//  AppStoreSearchiOS
//
//  Created by Lee Sam on 2023/09/17.
//

import Foundation

public struct AppTitleViewModel {
    public let title: String
    public let description: String
    public let logoImage: URL
    
    public init(title: String, description: String, logoImage: URL) {
        self.title = title
        self.description = description
        self.logoImage = logoImage
    }
}
