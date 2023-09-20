//
//  AppUIIntegrationTests.swift
//  AppStoreSearchAppTests
//
//  Created by Lee Sam on 2023/09/20.
//

import XCTest
import Combine
import AppStoreSearch
import AppStoreSearchiOS
import AppStoreSearchApp

class AppUIIntegrationTests: XCTestCase {
    
    func test_viewDidLoad() {
        let (sut, list, _) = makeSUT()
        
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(list.numberOfViews(in: section), numberOfViews, "앱 화면이 로드 되면 타이틀, 설명, 새로운 기능, 미리보기 \(numberOfViews)개의 뷰가 보여져야 한다")
    }
    
    // MARK: - Helpers
    
    private func makeSUT(
        app: App = makeApp(id: 0),
        callback: @escaping () -> Void = {},
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> (
        sut: AppContainerViewController,
        list: ListViewController,
        imageDataLoader: AppsLoaderSpy
    ) {
        let imageDataLoader = AppsLoaderSpy()
        let sut = AppUIComposer.composedWith(
            app: app,
            imageDataLoader: imageDataLoader.loadImageData,
            callback: callback
        )
        let list = sut.listViewController!
        trackMemoryLeak(imageDataLoader, file: file, line: line)
        trackMemoryLeak(sut, file: file, line: line)
        trackMemoryLeak(list, file: file, line: line)
        return (sut, list, imageDataLoader)
    }
}

private var numberOfViews: Int { 4 }
private var section: Int { 0 }
