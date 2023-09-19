//
//  AppTitleViewModel.swift
//  AppStoreSearchiOS
//
//  Created by Lee Sam on 2023/09/17.
//

import Foundation

public struct AppTitleViewModel {
    public let title: String
    public let seller: String
    
    public init(title: String, seller: String) {
        self.title = title
        self.seller = seller
    }
}
