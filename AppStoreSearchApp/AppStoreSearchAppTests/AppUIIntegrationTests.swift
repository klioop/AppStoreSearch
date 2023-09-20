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
    
    func test_backAction_sendMessageToTriggerCallback() {
        var callbackMessages = [String]()
        let (sut, _, _) = makeSUT {
            callbackMessages.append("callback")
        }
        sut.loadViewIfNeeded()
        
        sut.simulateBackAction()
        XCTAssertEqual(callbackMessages.count, 1, "첫 번째 뒤로가기 액션은 주입받은 callback 에게 메세지를 한 번만 보낸다")
        
        sut.simulateBackAction()
        XCTAssertEqual(callbackMessages.count, 2, "두 번째 뒤로가기 액션은 주입받은 callback 에게 메세지를 두 번째로 보낸다")
    }
    
    func test_viewsVisible_requestsToImageDataLoading() {
        let logo = URL(string: "http://logo-image.com")!
        let images = [
            URL(string: "http://app-image0.com")!,
            URL(string: "http://app-image0.com")!,
            URL(string: "http://app-image0.com")!
        ]
        let app = makeApp(id: 1, logo: logo, images: images)
        let (sut, list, imageDataLoader) = makeSUT(app: app)
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(imageDataLoader.requestedURLs, [], "뷰들이 화면에 보이기 전에는 이미지 데이터를 요청하지 않는다")
        
        list.simulateTitleVisible()
        XCTAssertEqual(imageDataLoader.requestedURLs, [logo], "타이틀 뷰가 화면에 보이면 로고 이미지 데이터를 요청한다")
        
        let preview = list.simulatePreviewVisible()
        images.enumerated().forEach { index, _ in
            preview?.simulateGalleryViewsVisible(in: index)
        }
        XCTAssertEqual(imageDataLoader.requestedURLs, [logo] + images, "preview 가 화면에 보이고 스크린샷을 나타내는 갤러리 뷰가 화면에 나타나면, 앱 이미지 데이터를 요청한다")
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
private var gallerySection: Int { 0 }
private var titleRow: Int { 0 }
private var previewRow: Int { 3 }

private extension AppContainerViewController {
    func simulateBackAction() {
        header.button.sendActions(for: .touchUpInside)
    }
}

private extension ListViewController {
    
    @discardableResult
    func simulateTitleVisible() -> AppTitleCell? {
        cell(in: titleRow, section: section) as? AppTitleCell
    }
    
    @discardableResult
    func simulatePreviewVisible() -> AppPreviewCell? {
        cell(in: previewRow, section: section) as? AppPreviewCell
    }
}

private extension AppPreviewCell {
    
    @discardableResult
    func simulateGalleryViewsVisible(in item: Int) -> AppGalleryCell? {
        galleryImageView(in: item) as? AppGalleryCell
    }
    
    func galleryImageView(in item: Int) -> UICollectionViewCell? {
        let ds = gallery.dataSource
        let indexPath = IndexPath(item: item, section: gallerySection)
        return ds?.collectionView(gallery, cellForItemAt: indexPath)
    }
}
