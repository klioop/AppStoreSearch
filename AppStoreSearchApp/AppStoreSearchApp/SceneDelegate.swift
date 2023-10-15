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
    private lazy var store: SearchTermStore = try! UserDefaultsSearchTermStore(suiteName: "klioop.AppStoreSearchTermStore")
    private lazy var localSearchTermsLoader = LocalSearchTermLoader(store: store)
    
    private lazy var navigationController: UINavigationController = {
        let nav = UINavigationController()
        nav.setNavigationBarHidden(true, animated: false)
        return nav
    }()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        configureWindow()
    }
    
    // MARK: - Helpers
    
    private func configureWindow() {
        navigationController.setViewControllers([searchViewController()], animated: false)
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
            recentTermsLoader: recentSearchTermsLoader,
            matchedTermsLoader: matchedSearchTermsLoader,
            appsLoader: appsLoader,
            imageDataLoader: imageDataLoader,
            save: save,
            selection: showApp
        )
    }
    
    private func recentSearchTermsLoader() -> AnyPublisher<[SearchTerm], Error> {
        localSearchTermsLoader.loadPublisher()
    }
    
    private func matchedSearchTermsLoader(containing searchTerm: SearchTerm) -> AnyPublisher<[SearchTerm], Error> {
        localSearchTermsLoader.loadPublisher(containing: searchTerm)
    }
    
    private func appsLoader(for searchTerm: SearchTerm) -> AnyPublisher<[App], Error> {
        let request = URLRequest(url: AppStoreSearchEndPoint.get(searchTerm).url())
        return httpClient
            .performPublisher(request)
            .logRequestInfo(of: request)
            .tryMap(AppMapper.map)
            .eraseToAnyPublisher()
    }
    
    private func imageDataLoader(from url: URL) -> AnyPublisher<Data, Error> {
        let request = URLRequest(url: url)
        return httpClient
            .performPublisher(request)
            .tryMap(ImageDataMapper.map)
            .eraseToAnyPublisher()
    }
    
    private func save(_ searchTerm: SearchTerm) {
        localSearchTermsLoader.saveIgnoringResult(LocalSearchTerm(from: searchTerm))
    }
}
