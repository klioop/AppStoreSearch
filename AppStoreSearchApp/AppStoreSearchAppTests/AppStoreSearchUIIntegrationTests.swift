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
    
    func test_viewDidLoad_rendersNoTitleAndRecentTermsOnEmptyRecentSearchTerms() {
        let termLoader = SearchTermLoaderSpy()
        let sut = AppStoreSearchUIComposer.composedWith(termLoader: termLoader.loadPublisher)
        let list = sut.listViewController
        
        sut.loadViewIfNeeded()
        termLoader.loadComplete(with: [])
        
        let tableView = list?.tableView
        XCTAssertEqual(tableView?.numberOfSections, 2)
        XCTAssertEqual(tableView?.numberOfRows(inSection: 0), 1)
        XCTAssertEqual(tableView?.numberOfRows(inSection: 1), 0)
    }
    
    private class SearchTermLoaderSpy {
        private var searchTermRequests: [PassthroughSubject<[SearchTerm], Error>] = []
        
        func loadPublisher() -> AnyPublisher<[SearchTerm], Error> {
            let subject = PassthroughSubject<[SearchTerm], Error>()
            searchTermRequests.append(subject)
            return subject.eraseToAnyPublisher()
        }
        
        func loadComplete(with searchTerms: [SearchTerm], at index: Int = 0) {
            searchTermRequests[index].send(searchTerms)
            searchTermRequests[index].send(completion: .finished)
        }
    }
}
