//
//  AppFlow.swift
//  AppStoreSearchApp
//
//  Created by Lee Sam on 12/13/23.
//

import UIKit
import AppStoreSearchiOS

public final class AppFlow {
    public let appSearchFlow: AppSearchFlow
    
    public init(appSearchFlow: AppSearchFlow) {
        self.appSearchFlow = appSearchFlow
    }
    
    public func start() {
        appSearchFlow.start()
    }
}
