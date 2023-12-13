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
    
    private lazy var navigationController: UINavigationController = {
        let nav = UINavigationController()
        nav.setNavigationBarHidden(true, animated: false)
        return nav
    }()
    
    private lazy var appFlow = FlowFactory(navigationController: navigationController).makeAppFlow()
    
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
}
