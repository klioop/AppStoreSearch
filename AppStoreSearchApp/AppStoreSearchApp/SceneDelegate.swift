//
//  SceneDelegate.swift
//  AppStoreSearchApp
//
//  Created by Lee Sam on 2023/09/18.
//

import UIKit
import Combine
import AppStoreSearch
import AppStoreSearchiOS

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    private lazy var httpClient: HTTPClient = URLSessionHTTPClient(session: .shared)
    
    private lazy var navigationController: UINavigationController = {
        let nav = UINavigationController()
        nav.setNavigationBarHidden(true, animated: false)
        return nav
    }()
    
    private lazy var appSearchService = AppSearchServiceContainer(httpClient: httpClient)
    
    private lazy var appFlow = AppFlow(
        navigation: navigationController,
        makeAppStoreSearchContainerViewController: searchViewController
    )
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        configureWindow()
        appFlow.start()
    }
    
    // MARK: - Helpers
    
    private func configureWindow() {
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    private func showApp(_ app: App) {
        navigationController.pushViewController(viewController(for: app), animated: true)
    }
    
    private func viewController(for app: App) -> AppContainerViewController {
        AppUIComposer.composedWith(
            app: app,
            imageDataLoader: imageDataLoader,
            callback: { [weak navigationController] in
                navigationController?.popViewController(animated: true)
            }
        )
    }
    
    private func searchViewController() -> AppStoreSearchContainerViewController {
        AppStoreSearchUIComposer.composedWith(
            recentTermsLoader: appSearchService.recentSearchTermsLoader,
            matchedTermsLoader: appSearchService.matchedSearchTermsLoader,
            appsLoader: appSearchService.appsLoader,
            imageDataLoader: imageDataLoader,
            save: appSearchService.save,
            selection: showApp
        )
    }
    
    private func imageDataLoader(from url: URL) -> AnyPublisher<Data, Error> {
        let request = URLRequest(url: url)
        return httpClient
            .performPublisher(request)
            .tryMap(ImageDataMapper.map)
            .eraseToAnyPublisher()
    }
}
