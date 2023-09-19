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
        let searchLiteral = "search"
        let searchTerm = makeTerm(searchLiteral)
        var termsSearched = [SearchTerm]()
        let (sut, list, termsLoader, appsLoader) = makeSUT { termsSearched.append($0) }
        let recentTerms = [makeTerm("recent0"), makeTerm("recent1")]
        let appsFound = [makeApp(with: 0), makeApp(with: 1), makeApp(with: 2)]
        sut.loadViewIfNeeded()
        termsLoader.loadComplete(with: recentTerms)
        
        sut.simulateDidSearch(with: searchLiteral)
        XCTAssertEqual(termsSearched, [searchTerm], "검색을 하면 검색어가 저장된다")
        
        appsLoader.loadComplete(with: appsFound)
        XCTAssertEqual(list.numberOfViews(in: appsFoundSection), appsFound.count, "검색 후, 찾아진 앱이 \(appsFound.count)개가 보인다")
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
    }
    
    private func makeTerm(_ term: String) -> SearchTerm {
        SearchTerm(term: term)
    }
    
    private func makeApp(with id: Int) -> App {
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
            logo: anyURL(),
            images: [anyURL()]
        )
    }
    
    private func anyURL() -> URL {
        URL(string: "http://any-url.com")!
    }
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
}
