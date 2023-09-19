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
        
        XCTAssertEqual(list.numberOfViews(in: recentTitleSection), 1)
        XCTAssertEqual(list.numberOfViews(in: recentTermsSection), 0)
    }
    
    func test_viewDidLoad_rendersTitleAndRecentTermsOnNonEmptyRecentSearchTerms() {
        let (sut, list, termsLoader) = makeSUT()
        let recentTerms = [makeTerm("term0"), makeTerm("term1")]
        
        sut.loadViewIfNeeded()
        termsLoader.loadComplete(with: recentTerms)
        
        XCTAssertEqual(list.numberOfViews(in: recentTitleSection), 1)
        XCTAssertEqual(list.numberOfViews(in: recentTermsSection), recentTerms.count)
    }
    
    func test_viewDidLoad_rendersMatchedTermsWhenSearchBarTextChanged() {
        let (sut, list, termsLoader) = makeSUT()
        let recentTerms = [makeTerm("any"), makeTerm("matched0"), makeTerm("matched1")]
        let matchedTerms = [makeTerm("matched0"), makeTerm("matched1")]
        sut.loadViewIfNeeded()
        termsLoader.loadComplete(with: recentTerms, at: 0)
        
        XCTAssertEqual(list.numberOfViews(in: recentTitleSection), 1)
        XCTAssertEqual(list.numberOfViews(in: recentTermsSection), recentTerms.count)
        
        sut.searchView.onTextChange?("match")
        termsLoader.loadComplete(with: matchedTerms, at: 1)
        
        XCTAssertEqual(list.numberOfViews(in: matchedTermsSection), matchedTerms.count)
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
