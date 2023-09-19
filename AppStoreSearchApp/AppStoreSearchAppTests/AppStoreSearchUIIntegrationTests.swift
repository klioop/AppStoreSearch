//
//  AppStoreSearchUIIntegrationTests.swift
//  AppStoreSearchUIIntegrationTests
//
//  Created by Lee Sam on 2023/09/18.
//

import XCTest
import Combine
import AppStoreSearch
import AppStoreSearchiOS
import AppStoreSearchApp

final class AppStoreSearchUIIntegrationTests: XCTestCase {
    
    func test_viewDidLoad_rendersOnlyTitleOnEmptyRecentSearchTerms() {
        let (sut, list, termsLoader, _) = makeSUT()
        
        sut.loadViewIfNeeded()
        termsLoader.loadComplete(with: [])
        
        XCTAssertEqual(list.numberOfViews(in: recentTitleSection), 1, "뷰가 로드되면, 최근 검색어 제목이 보여야 한다")
        XCTAssertEqual(list.numberOfViews(in: recentTermsSection), 0, "뷰가 로드되면, 최근 검색어가 없을 때 아무 검색어도 보이면 안된다")
    }
    
    func test_searchBarState_rendersRecentAndMatchedSearchTerms() {
        let (sut, list, termsLoader, _) = makeSUT()
        let matchedTerms = [makeTerm("matched0"), makeTerm("matched1")]
        let recentTerms = [makeTerm("any")] + matchedTerms
        sut.loadViewIfNeeded()
        termsLoader.loadComplete(with: recentTerms, at: 0)
        
        XCTAssertEqual(list.numberOfViews(in: recentTitleSection), 1, "뷰가 로드되면, 최근 검색어 제목이 보여야 한다")
        XCTAssertEqual(list.numberOfViews(in: recentTermsSection), recentTerms.count, "뷰가 로드되면, 최근 검색어가 있을 때 검색어 \(recentTerms.count)개 보여야한다")
        
        sut.simulateDidSearchTextChange("match")
        termsLoader.loadComplete(with: matchedTerms, at: 1)
        XCTAssertEqual(list.numberOfViews(in: matchedTermsSection), matchedTerms.count, "검색바에 검색어가 변할 때 마다, 최근 검색어와 매칭된 검색어가 있으면 매칭된 검색어 \(matchedTerms.count)개가 보여야 한다")
        
        sut.simulateDidSearchTextChange("")
        termsLoader.loadComplete(with: recentTerms, at: 2)
        XCTAssertEqual(list.numberOfViews(in: recentTermsSection), recentTerms.count, "검색바에 검색어가 빈 값으로 변하면, 최근 검색어 \(recentTerms.count)개가 보여야 한다")
        XCTAssertEqual(list.numberOfViews(in: recentTitleSection), 1, "최근 검색어 리스트가 로드되면, 최근 검색어 제목이 보여야 한다")
        
        sut.simulateDidSearchTextChange("mat")
        termsLoader.loadComplete(with: matchedTerms, at: 3)
        XCTAssertEqual(list.numberOfViews(in: matchedTermsSection), matchedTerms.count, "검색바에 검색어가 변할 때 마다, 최근 검색어와 매칭된 검색어가 있으면, 매칭된 검색어 \(matchedTerms.count)개가 보여야 한다")
        
        sut.simulateDidCancelSearch()
        termsLoader.loadComplete(with: recentTerms, at: 4)
        XCTAssertEqual(list.numberOfViews(in: recentTermsSection), recentTerms.count, "검색어 입력 중 취소하면, 최근 검색어 \(recentTerms)개가 보여야 한다")
        XCTAssertEqual(list.numberOfViews(in: recentTitleSection), 1, "최근 검색어 리스트가 로드되면, 최근 검색어 제목이 보여야 한다")
    }
    
    func test_search_savesTheSearchTermAndLoadsFoundApp() {
        let firstTermLiteral = "first search"
        let secondTermLiteral = "second search"
        let firstSearchTerm = makeTerm(firstTermLiteral)
        let secondSearchTerm = makeTerm(secondTermLiteral)
        var termsSearched = [SearchTerm]()
        let (sut, list, termsLoader, appsLoader) = makeSUT { termsSearched.append($0) }
        let recentTerms = [makeTerm("recent0"), makeTerm("recent1")]
        let firstAppsFound = [makeApp(id: 0), makeApp(id: 1), makeApp(id: 2)]
        let secondAppsFound = [makeApp(id: 0), makeApp(id: 1)]
        sut.loadViewIfNeeded()
        termsLoader.loadComplete(with: recentTerms)
        
        sut.simulateDidSearch(with: firstTermLiteral)
        XCTAssertEqual(termsSearched, [firstSearchTerm], "검색을 하면 검색어가 저장된다")
        
        appsLoader.loadComplete(with: firstAppsFound, at: 0)
        XCTAssertEqual(list.numberOfViews(in: appsFoundSection), firstAppsFound.count, "검색 후, 찾아진 앱 \(firstAppsFound.count)개가 보인다")
        
        sut.simulateDidSearch(with: secondTermLiteral)
        XCTAssertEqual(termsSearched, [firstSearchTerm, secondSearchTerm], "검색을 하면 검색어가 저장된다")
        
        appsLoader.loadComplete(with: secondAppsFound, at: 1)
        XCTAssertEqual(list.numberOfViews(in: appsFoundSection), secondAppsFound.count, "검색 후, 찾아진 앱 \(secondAppsFound.count)개가 보인다")
    }
    
    func test_appViewVisible_requestsLogoImageAndAppImages() {
        let (sut, list, _, appsLoader) = makeSUT()
        let logo0 = URL(string: "http//:logo0.com")!
        let logo1 = URL(string: "http//:logo1.com")!
        let images0 = [URL(string: "http//:app0-image0.com")!, URL(string: "http//:app0-image1.com")!]
        let images1 = [URL(string: "http//:app1-image0.com")!, URL(string: "http//:app1-image1.com")!]
        let app0 = makeApp(id: 0, logo: logo0, images: images0)
        let app1 = makeApp(id: 1, logo: logo1, images: images1)
        
        sut.loadViewIfNeeded()
        sut.simulateDidSearch(with: "any")
        appsLoader.loadComplete(with: [app0, app1])
        XCTAssertEqual(appsLoader.requestedURLs, [], "첫번째 앱이 화면에 보이기 전에는 어떤 이미지도 요청하지 않는다")
        
        let view0 = list.simulateAppViewVisible(in: 0)
        view0?.simulateGalleryViewVisible(in: 0)
        view0?.simulateGalleryViewVisible(in: 1)
        XCTAssertEqual(appsLoader.requestedURLs, [app0.logo] + app0.images, "첫 번째 앱이 화면에 보이면 로고이미지와 앱 이미지 리스트를 한 번 요청한다")
        
        let view1 = list.simulateAppViewVisible(in: 1)
        view1?.simulateGalleryViewVisible(in: 0)
        view1?.simulateGalleryViewVisible(in: 1)
        XCTAssertEqual(appsLoader.requestedURLs, [app0.logo] + app0.images + [app1.logo] + app1.images, "두 번째 앱이 화면에 보이면 로고이미지와 앱 이미지 리스트를 두 번 요청한다")
    }
    
    func test_appViewNotVisible_cancelsRequestsImagesBeforeCompleteImageLoading() {
        let (sut, list, _, appsLoader) = makeSUT()
        let logo0 = URL(string: "http//:logo0.com")!
        let logo1 = URL(string: "http//:logo1.com")!
        let images0 = [URL(string: "http//:app0-image0.com")!, URL(string: "http//:app0-image1.com")!]
        let images1 = [URL(string: "http//:app1-image0.com")!, URL(string: "http//:app1-image1.com")!]
        let app0 = makeApp(id: 0, logo: logo0, images: images0)
        let app1 = makeApp(id: 1, logo: logo1, images: images1)
        
        sut.loadViewIfNeeded()
        sut.simulateDidSearch(with: "any")
        appsLoader.loadComplete(with: [app0, app1])
        XCTAssertEqual(appsLoader.cancelImageURLs, [], "첫번째 앱이 화면에 보이기 전에는 이미지 요청을 취소하지 않는다")
        
        let view0 = list.simulateAppViewNotVisible(in: 0)
        view0?.simulateGalleryViewNotVisible(in: 0)
        view0?.simulateGalleryViewNotVisible(in: 1)
        XCTAssertEqual(appsLoader.cancelImageURLs, [app0.logo] + app0.images, "첫 번째 앱이 화면에 보인후 이미지 로딩이 완료되지 않고 화면에서 사라지면, 로고이미지와 앱 이미지 리스트 요청을 한 번 취소한다")
        
        let view1 = list.simulateAppViewNotVisible(in: 1)
        view1?.simulateGalleryViewNotVisible(in: 0)
        view1?.simulateGalleryViewNotVisible(in: 1)
        XCTAssertEqual(appsLoader.requestedURLs, [app0.logo] + app0.images + [app1.logo] + app1.images, "두 번째 앱이 화면에 보인후 이미지 로딩이 완료되지 않고 화면에서 사라지면, 로고이미지와 앱 이미지 리스트 요청을 두 번 취소한다")
    }
    
    // MARK: - Helpers
    
    private func makeSUT(
        save: @escaping (SearchTerm) -> Void = {_ in },
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> (
        sut: AppStoreSearchContainerViewController,
        list: ListViewController,
        termsLoader: SearchTermsLoaderSpy,
        appsLoader: AppsLoaderSpy
    ) {
        let termsLoader = SearchTermsLoaderSpy()
        let appsLoader = AppsLoaderSpy()
        let sut = AppStoreSearchUIComposer.composedWith(
            recentTermsLoader: termsLoader.loadPublisher,
            matchedTermsLoader: termsLoader.loadPublisher(containing:),
            appsLoader: appsLoader.loadPublisher,
            imageDataLoader: appsLoader.loadImageData,
            save: save
        )
        let list = sut.listViewController!
        trackMemoryLeak(termsLoader, file: file, line: line)
        trackMemoryLeak(sut, file: file, line: line)
        trackMemoryLeak(list, file: file, line: line)
        return (sut, list, termsLoader, appsLoader)
    }
    
    private class SearchTermsLoaderSpy {
        private var searchTermRequests: [PassthroughSubject<[SearchTerm], Error>] = []
        
        func loadPublisher() -> AnyPublisher<[SearchTerm], Error> {
            let subject = PassthroughSubject<[SearchTerm], Error>()
            searchTermRequests.append(subject)
            return subject.eraseToAnyPublisher()
        }
        
        func loadPublisher(containing searchTerm: SearchTerm) -> AnyPublisher<[SearchTerm], Error> {
            let subject = PassthroughSubject<[SearchTerm], Error>()
            searchTermRequests.append(subject)
            return subject.eraseToAnyPublisher()
        }
        
        func loadComplete(with searchTerms: [SearchTerm], at index: Int = 0) {
            searchTermRequests[index].send(searchTerms)
            searchTermRequests[index].send(completion: .finished)
        }
    }
    
    private class AppsLoaderSpy {
        private var appsRequests: [PassthroughSubject<[App], Error>] = []
        
        func loadPublisher(for searchTerm: SearchTerm) -> AnyPublisher<[App], Error> {
            let subject = PassthroughSubject<[App], Error>()
            appsRequests.append(subject)
            return subject.eraseToAnyPublisher()
        }
        
        func loadComplete(with apps: [App], at index: Int = 0) {
            appsRequests[index].send(apps)
            appsRequests[index].send(completion: .finished)
        }
        
        // MARK: - Image Data Loader Spy
        
        private var imageRequests: [(url: URL, subject: PassthroughSubject<Data, Error>)] = []
        private(set) var cancelImageURLs: [URL] = []
        
        var requestedURLs: [URL] {
            imageRequests.map(\.url)
        }
        
        func loadImageData(from url: URL) -> AnyPublisher<Data, Error> {
            let subject = PassthroughSubject<Data, Error>()
            imageRequests.append((url, subject))
            return subject
                .handleEvents(receiveCancel: { [weak self] in
                    self?.cancelImageURLs.append(url)
                })
                .eraseToAnyPublisher()
                
        }
        
        func loadCompleteImage(with data: Data, at index: Int = 0) {
            imageRequests[index].subject.send(data)
            imageRequests[index].subject.send(completion: .finished)
        }
    }
    
    private func makeTerm(_ term: String) -> SearchTerm {
        SearchTerm(term: term)
    }
    
    private func makeApp(id: Int, logo: URL = anyURL(), images: [URL] = [anyURL()]) -> App {
        App(
            id: AppID(id: id),
            title: "a title",
            seller: "a seller",
            rating: 4.8888,
            numberOfRatings: 3,
            version: "x.xx.x",
            currentReleaseDate: Date(),
            releaseNotes: "a release note",
            genre: "a genre",
            age: "a age",
            logo: logo,
            images: images
        )
    }
}

func anyURL() -> URL {
    URL(string: "http://any-url.com")!
}

var recentTitleSection: Int { 0 }
var recentTermsSection: Int { 1 }
var matchedTermsSection: Int { 0 }
var appsFoundSection: Int { 0 }

extension AppStoreSearchContainerViewController {
    func simulateDidSearch(with term: String) {
        searchView.onTapSearch?(term)
    }
    
    func simulateDidSearchTextChange(_ text: String) {
        searchView.onTextChange?(text)
    }
    
    func simulateDidCancelSearch() {
        searchView.onTapCancel?()
    }
}

extension ListViewController {
    func numberOfViews(in section: Int) -> Int {
        tableView.numberOfRows(inSection: section)
    }
    
    @discardableResult
    func simulateAppViewVisible(in row: Int, section: Int = appsFoundSection) -> AppStoreSearchResultCell? {
        cell(in: row) as? AppStoreSearchResultCell
    }
    
    @discardableResult
    func simulateAppViewNotVisible(in row: Int, section: Int = appsFoundSection) -> AppStoreSearchResultCell? {
        let view = simulateAppViewVisible(in: row, section: section)
        let dl = tableView.delegate
        let indexPath = IndexPath(row: row, section: section)
        dl?.tableView?(tableView, didEndDisplaying: view!, forRowAt: indexPath)
        return view
    }
    
    
    func cell(in row: Int, section: Int = appsFoundSection) -> UITableViewCell? {
        let ds = tableView.dataSource
        let indexPath0 = IndexPath(row: row, section: section)
        return ds?.tableView(tableView, cellForRowAt: indexPath0)
    }
}

extension AppStoreSearchResultCell {
    
    @discardableResult
    func simulateGalleryViewVisible(in item: Int) -> AppGalleryCell? {
        galleryImageView(in: item) as? AppGalleryCell
    }
    
    @discardableResult
    func simulateGalleryViewNotVisible(in item: Int) -> AppGalleryCell? {
        let view = galleryImageView(in: item) as? AppGalleryCell
        let dl = gallery.delegate
        let indexPath = IndexPath(item: item, section: 0)
        dl?.collectionView?(gallery, didEndDisplaying: view!, forItemAt: indexPath)
        return view
    }
    
    
    func galleryImageView(in item: Int) -> UICollectionViewCell? {
        let ds = gallery.dataSource
        let indexPath = IndexPath(item: item, section: 0)
        return ds?.collectionView(gallery, cellForItemAt: indexPath)
    }
}
