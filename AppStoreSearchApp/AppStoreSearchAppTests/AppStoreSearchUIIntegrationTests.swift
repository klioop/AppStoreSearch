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
        let (sut, list, termsLoader) = makeSUT()
        
        sut.loadViewIfNeeded()
        termsLoader.loadComplete(with: [])
        
        XCTAssertEqual(list.numberOfViews(in: recentTitleSection), 1, "뷰가 로드되면, 최근 검색어 제목이 보여야 한다")
        XCTAssertEqual(list.numberOfViews(in: recentTermsSection), 0, "뷰가 로드되면, 최근 검색어가 없을 때 아무 검색어도 보이면 안된다")
    }
    
    func test_viewDidLoad_rendersTitleAndRecentTermsOnNonEmptyRecentSearchTerms() {
        let (sut, list, termsLoader) = makeSUT()
        let recentTerms = [makeTerm("term0"), makeTerm("term1")]
        
        sut.loadViewIfNeeded()
        termsLoader.loadComplete(with: recentTerms)
        
        XCTAssertEqual(list.numberOfViews(in: recentTitleSection), 1, "뷰가 로드되면, 최근 검색어 제목이 보여야 한다")
        XCTAssertEqual(list.numberOfViews(in: recentTermsSection), recentTerms.count, "뷰가 로드되면, 최근 검색어가 있을 때 검색어가 보여야한다")
    }
    
    func test_searchBarState_rendersRecentAndMatchedSearchTerms() {
        let (sut, list, termsLoader) = makeSUT()
        let recentTerms = [makeTerm("any"), makeTerm("matched0"), makeTerm("matched1")]
        let matchedTerms = [makeTerm("matched0"), makeTerm("matched1")]
        sut.loadViewIfNeeded()
        termsLoader.loadComplete(with: recentTerms, at: 0)
        
        XCTAssertEqual(list.numberOfViews(in: recentTitleSection), 1, "뷰가 로드되면, 최근 검색어 제목이 보여야 한다")
        XCTAssertEqual(list.numberOfViews(in: recentTermsSection), recentTerms.count, "뷰가 로드되면, 최근 검색어가 있을 때 검색어가 보여야한다")
        
        sut.searchView.onTextChange?("match")
        termsLoader.loadComplete(with: matchedTerms, at: 1)
        XCTAssertEqual(list.numberOfViews(in: matchedTermsSection), matchedTerms.count, "검색바에 검색어가 변할 때 마다, 최근 검색어와 매칭된 검색어가 있으면 매칭된 검색어들만 보여야 한다")
        
        sut.searchView.onTextChange?("")
        termsLoader.loadComplete(with: recentTerms, at: 2)
        XCTAssertEqual(list.numberOfViews(in: recentTermsSection), recentTerms.count, "검색바에 검색어가 빈 값으로 변하면, 최근 검색어 리스트가 보여야 한다")
        XCTAssertEqual(list.numberOfViews(in: recentTitleSection), 1, "최근 검색어 리스트가 로드되면, 최근 검색어 제목이 보여야 한다")
        
        sut.searchView.onTextChange?("mat")
        termsLoader.loadComplete(with: matchedTerms, at: 3)
        XCTAssertEqual(list.numberOfViews(in: matchedTermsSection), matchedTerms.count, "검색바에 검색어가 변할 때 마다, 최근 검색어와 매칭된 검색어가 있으면 매칭된 검색어들만 보여야 한다")
        
        sut.searchView.onTapCancel?()
        termsLoader.loadComplete(with: recentTerms, at: 4)
        XCTAssertEqual(list.numberOfViews(in: recentTermsSection), recentTerms.count, "검색바에 검색어가 빈 값으로 변하면, 최근 검색어 리스트가 보여야 한다")
        XCTAssertEqual(list.numberOfViews(in: recentTitleSection), 1, "최근 검색어 리스트가 로드되면, 최근 검색어 제목이 보여야 한다")
    }
    
    // MARK: - Helpers
    
    private func makeSUT(
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> (
        sut: AppStoreSearchContainerViewController,
        list: ListViewController,
        termsLoader: SearchTermsLoaderSpy
    ) {
        let termsLoader = SearchTermsLoaderSpy()
        let appsLoader = AppsLoaderSpy()
        let sut = AppStoreSearchUIComposer.composedWith(
            recentTermsLoader:
                termsLoader.loadPublisher,
            matchedTermsLoader: termsLoader.loadPublisher(containing:),
            appsLoader: appsLoader.loadPublisher
        )
        let list = sut.listViewController!
        trackMemoryLeak(termsLoader, file: file, line: line)
        trackMemoryLeak(sut, file: file, line: line)
        trackMemoryLeak(list, file: file, line: line)
        return (sut, list, termsLoader)
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
}

var recentTitleSection: Int { 0 }
var recentTermsSection: Int { 1 }
var matchedTermsSection: Int { 0 }

extension ListViewController {
    func numberOfViews(in section: Int) -> Int {
        tableView.numberOfRows(inSection: section)
    }
}
