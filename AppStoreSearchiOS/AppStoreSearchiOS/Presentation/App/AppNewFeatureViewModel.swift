//
//  AppNewFeatureViewModel.swift
//  AppStoreSearchiOS
//
//  Created by Lee Sam on 2023/09/17.
//

import Foundation

public struct AppNewFeatureViewModel {
    public let title: String
    public let version: String
    public let firstDescription: String
    public let secondDescription: String
    
    public init(title: String, version: String, firstDescription: String, secondDescription: String) {
        self.title = title
        self.version = version
        self.firstDescription = firstDescription
        self.secondDescription = secondDescription
    }
}
