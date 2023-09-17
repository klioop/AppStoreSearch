//
//  AppStoreSearchViewModel.swift
//  AppStoreSearchiOS
//
//  Created by Lee Sam on 2023/09/16.
//

import Foundation

public struct AppStoreSearchViewModel {
    public let title: String
    public let placeholder: String
    
    public init(title: String, placeholder: String) {
        self.title = title
        self.placeholder = placeholder
    }
}
