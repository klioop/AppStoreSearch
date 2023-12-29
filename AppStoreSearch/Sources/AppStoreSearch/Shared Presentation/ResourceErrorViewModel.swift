//
//  ResourceErrorViewModel.swift
//  AppStoreSearch
//
//  Created by Lee Sam on 2023/09/18.
//

import Foundation

public struct ResourceErrorViewModel {
    public let message: String?
    
    public init(message: String?) {
        self.message = message
    }
    
    static var noError: ResourceErrorViewModel {
        ResourceErrorViewModel(message: nil)
    }
    
    public static func error(message: String) -> ResourceErrorViewModel {
        ResourceErrorViewModel(message: message)
    }
}
