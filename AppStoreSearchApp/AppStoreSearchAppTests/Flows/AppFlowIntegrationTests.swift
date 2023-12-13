//
//  AppFlowTests.swift
//  AppStoreSearchAppTests
//
//  Created by Lee Sam on 12/13/23.
//

import XCTest
import AppStoreSearchiOS
import AppStoreSearchApp

class AppFlowIntegrationTests: XCTestCase {
    
    func test_start_showsAppSearchScene() {
        let navigation = UINavigationController()
        let sut = FlowFactory(navigationController: navigation).makeAppFlow()
        
        sut.start()
        
        XCTAssertNotNil(navigation.viewControllers.first as? AppStoreSearchContainerViewController)
    }
}
