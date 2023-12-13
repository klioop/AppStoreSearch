//
//  AppSearchFlow.swift
//  AppStoreSearchApp
//
//  Created by Lee Sam on 12/13/23.
//

import UIKit
import Combine
import AppStoreSearch
import AppStoreSearchiOS

public final class AppSearchFlow {
    
    private let navigation: UINavigationController
    private let appDetailFlow: AppDetailFlow
    private let appSearchService: AppSearchServiceContainer
    private let imageDataLoader: (URL) -> AnyPublisher<Data, Error>
    
    public init(
        navigation: UINavigationController,
        appDetailFlow: AppDetailFlow,
        appSearchService: AppSearchServiceContainer,
        imageDataLoader: @escaping (URL) -> AnyPublisher<Data, Error>
    ) {
        self.navigation = navigation
        self.appDetailFlow = appDetailFlow
        self.appSearchService = appSearchService
        self.imageDataLoader = imageDataLoader
    }
    
    public func start() {
        navigation.setViewControllers([searchViewController()], animated: false)
    }
    
    private func searchViewController() -> AppStoreSearchContainerViewController {
        AppStoreSearchUIComposer.composedWith(
            recentTermsLoader: appSearchService.recentSearchTermsLoader,
            matchedTermsLoader: appSearchService.matchedSearchTermsLoader,
            appsLoader: appSearchService.appsLoader,
            imageDataLoader: imageDataLoader,
            save: appSearchService.save,
            selection: appDetailFlow.start
        )
    }
}
