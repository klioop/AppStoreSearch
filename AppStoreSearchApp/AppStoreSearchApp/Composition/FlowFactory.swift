//
//  FlowFactory.swift
//  AppStoreSearchApp
//
//  Created by Lee Sam on 12/13/23.
//

import UIKit
import Combine
import AppStoreSearch
import AppStoreSearchiOS

public final class FlowFactory {
    private lazy var httpClient: HTTPClient = URLSessionHTTPClient(session: .shared)
    private lazy var appSearchService = AppSearchServiceContainer(httpClient: httpClient)
    private lazy var sharedService = SharedServiceContainer(httpClient: httpClient)
    
    private let navigationController: UINavigationController
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func makeAppFlow() -> AppFlow {
        AppFlow(appSearchFlow: makeAppSearchFlow())
    }
    
    private func makeAppSearchFlow() -> AppSearchFlow {
        AppSearchFlow(
            navigation: navigationController,
            appDetailFlow: makeAppDetailFlow(),
            appSearchService: appSearchService,
            imageDataLoader: sharedService.imageDataLoader
        )
    }
    
    private func makeAppDetailFlow() -> AppDetailFlow {
        AppDetailFlow(
            navigation: navigationController,
            imageDataLoader: sharedService.imageDataLoader
        )
    }
}
