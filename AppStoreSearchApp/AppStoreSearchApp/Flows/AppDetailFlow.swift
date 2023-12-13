//
//  AppDetailFlow.swift
//  AppStoreSearchApp
//
//  Created by Lee Sam on 12/13/23.
//

import UIKit
import Combine
import AppStoreSearch
import AppStoreSearchiOS

public final class AppDetailFlow {
    
    private let navigation: UINavigationController
    private let imageDataLoader: (URL) -> AnyPublisher<Data, Error>
    
    init(navigation: UINavigationController, imageDataLoader: @escaping (URL) -> AnyPublisher<Data, Error>) {
        self.navigation = navigation
        self.imageDataLoader = imageDataLoader
    }
    
    func start(with app: App) {
        navigation.pushViewController(viewController(for: app), animated: true)
    }
    
    // MARK: - Helpers
    
    private func viewController(for app: App) -> AppContainerViewController {
        AppUIComposer.composedWith(
            app: app,
            imageDataLoader: imageDataLoader,
            callback: { [navigation] in
                navigation.popViewController(animated: true)
            }
        )
    }
}
