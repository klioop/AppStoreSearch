//
//  AppFlowTests.swift
//  AppStoreSearchAppTests
//
//  Created by Lee Sam on 12/13/23.
//

import XCTest
import AppStoreSearchiOS
import AppStoreSearchApp

class AppFlowTests: XCTestCase {
    
    func test_() {
        let sut = AppFlow(
            navigation: UINavigationController(),
            makeAppStoreSearchContainerViewController: { AppStoreSearchContainerViewController() }
        )
        
        sut.start()
        
        XCTAssertNotNil(sut.navigation.viewControllers.first as? AppStoreSearchContainerViewController)
    }
}
