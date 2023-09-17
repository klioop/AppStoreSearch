//
//  AppStoreSearchUISnapshotTests.swift
//  AppStoreSearchiOSTests
//
//  Created by Lee Sam on 2023/09/16.
//

import XCTest
import AppStoreSearchiOS

final class AppStoreSearchUISnapshotTests: XCTestCase {
    
    func test_appStoreSearchWithoutRecentTermsUI() {
        let (sut, list) = makeSUT()
        
        list.display(emptyRecentTerms())
        sut.loadViewIfNeeded()
        
        record(sut.snapshot(for: .iPhone11(style: .light)), named: "APPSTORE_SEARCH_WITHOUT_RECENT_TERMS_light")
    }
    
    func test_appStoreSearchWithRecentTermsUI() {
        let (sut, list) = makeSUT()
        
        list.display(recentTerms())
        sut.loadViewIfNeeded()
        
        record(sut.snapshot(for: .iPhone11(style: .light)), named: "APPSTORE_SEARCH_WITH_RECENT_TERMS_light")
    }
    
    func test_appStoreSearchWithMatchedRecentTermsUI() {
        let (sut, list) = makeSUT()
        
        list.display(matchedRecentTerms())
        sut.loadViewIfNeeded()
        
        record(sut.snapshot(for: .iPhone11(style: .light)), named: "APPSTORE_SEARCH_WITH_MATCHED_RECENT_TERMS_light")
    }
    
    func test_appStoreSearchResultsUI() {
        let (sut, list) = makeSUT()
        
        list.display(searchResults())
        sut.loadViewIfNeeded()
        
        record(sut.snapshot(for: .iPhone11(style: .light)), named: "APPSTORE_SEARCH_RESULT_light")
    }
    
    // MARK: - Helpers
    
    private func makeSUT() -> (sut: AppStoreSearchContainerViewController, list: ListViewController) {
        let searchViewController = AppStoreSearchViewController(
            viewModel: AppStoreSearchViewModel(title: "a title", placeholder: "a placeholder")
        )
        let list = ListViewController()
        let sut = AppStoreSearchContainerViewController(
            searchView: searchViewController.view(),
            listViewController: list
        )
        list.configure = { tableView in
            AppStoreSearchResultCellController.register(for: tableView)
        }
        return (sut, list)
    }
    
    private func emptyRecentTerms() -> [TableCellController] {
        []
    }
    
    private func recentTerms() -> [TableCellController] {
        let titleCellController = AppStoreRecentSearchTitleCellController(viewModel: "a title")
        let termCellController0 = AppStoreRecentSearchTermCellController(
            viewModel: AppStoreRecentSearchTermViewModel(term: "a term0")
        )
        let termCellController1 = AppStoreRecentSearchTermCellController(
            viewModel: AppStoreRecentSearchTermViewModel(term: "a term1")
        )
        let termCellController2 = AppStoreRecentSearchTermCellController(
            viewModel: AppStoreRecentSearchTermViewModel(term: "a term2")
        )
        return [titleCellController, termCellController0, termCellController1, termCellController2].map(TableCellController.init)
    }
    
    private func matchedRecentTerms() -> [TableCellController] {
        let termCellController0 = AppStoreRecentSearchTermCellController(
            viewModel: AppStoreRecentSearchTermViewModel(
                isMatchedRecent: true,
                term: "a term0"
            )
        )
        let termCellController1 = AppStoreRecentSearchTermCellController(
            viewModel: AppStoreRecentSearchTermViewModel(
                isMatchedRecent: true,
                term: "a term1"
            )
        )
        return [termCellController0, termCellController1].map(TableCellController.init)
    }
    
    private func searchResults() -> [TableCellController] {
        let view0 = AppStoreSearchResultCellController(
            viewModel: AppStoreSearchResultViewModel(
                title: "a title",
                description: "a description",
                ratings: (3, 0.44),
                numberOfRatingsText: "1.1만",
                logoImage: URL(string: "https:any-url.com")!,
                images: [URL(string: "https:any-url.com")!]
            )
        )
        let view1 = AppStoreSearchResultCellController(
            viewModel: AppStoreSearchResultViewModel(
                title: "a title",
                description: "a description",
                ratings: (4, 0.44),
                numberOfRatingsText: "3.7천",
                logoImage: URL(string: "https:any-url.com")!,
                images: [URL(string: "https:any-url.com")!]
            )
        )
        return [view0, view1].map(TableCellController.init)
    }
}
