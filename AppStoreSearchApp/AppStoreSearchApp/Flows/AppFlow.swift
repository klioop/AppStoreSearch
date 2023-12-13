//
//  AppFlow.swift
//  AppStoreSearchApp
//
//  Created by Lee Sam on 12/13/23.
//

import UIKit
import AppStoreSearchiOS

public final class AppFlow {
    public let navigation: UINavigationController
    public let makeAppStoreSearchContainerViewController: () -> AppStoreSearchContainerViewController
    
    public init(
        navigation: UINavigationController,
        makeAppStoreSearchContainerViewController: @escaping () -> AppStoreSearchContainerViewController
    ) {
        self.navigation = navigation
        self.makeAppStoreSearchContainerViewController = makeAppStoreSearchContainerViewController
    }
    
    public func start() {
        navigation.setViewControllers([makeAppStoreSearchContainerViewController()], animated: false)
    }
}
