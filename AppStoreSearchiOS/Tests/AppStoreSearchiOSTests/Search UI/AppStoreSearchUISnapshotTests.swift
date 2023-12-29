//
//  AppStoreSearchUISnapshotTests.swift
//  AppStoreSearchiOSTests
//
//  Created by Lee Sam on 2023/09/16.
//

import XCTest
import AppStoreSearchiOS
import AppStoreSearch

final class AppStoreSearchUISnapshotTests: XCTestCase {
    
    func test_appStoreSearchWithoutRecentTermsUI() {
        let (sut, list) = makeSUT()
        
        list.display(emptyRecentTerms())
        sut.loadViewIfNeeded()
        
        assert(sut.snapshot(for: .iPhone11(style: .light)), named: "APPSTORE_SEARCH_WITHOUT_RECENT_TERMS_light")
    }
    
    func test_appStoreSearchWithRecentTermsUI() {
        let (sut, list) = makeSUT()
        
        list.display(recentTerms())
        sut.loadViewIfNeeded()
        
        assert(sut.snapshot(for: .iPhone11(style: .light)), named: "APPSTORE_SEARCH_WITH_RECENT_TERMS_light")
    }
    
    func test_appStoreSearchWithMatchedRecentTermsUI() {
        let (sut, list) = makeSUT()
        
        list.display(matchedRecentTerms())
        sut.loadViewIfNeeded()
        
        assert(sut.snapshot(for: .iPhone11(style: .light)), named: "APPSTORE_SEARCH_WITH_MATCHED_RECENT_TERMS_light")
    }
    
    func test_appStoreSearchResultsUI() {
        let (sut, list) = makeSUT()
        
        list.display(searchResults())
        sut.loadViewIfNeeded()
        
        assert(sut.snapshot(for: .iPhone11(style: .light)), named: "APPSTORE_SEARCH_RESULT_light")
    }
    
    // MARK: - Helpers
    
    private func makeSUT() -> (sut: AppStoreSearchContainerViewController, list: ListViewController) {
        let searchViewController = AppStoreSearchViewController(
            viewModel: AppStoreSearchViewModel(
                title: "a title",
                placeholder: "a placeholder"
            ),
            searchCallback: {_ in },
            textChangeCallback: {_ in },
            cancelCallback: {}
        )
        let list = ListViewController()
        let sut = AppStoreSearchContainerViewController(
            searchView: searchViewController.view(),
            listViewController: list
        )
        list.configure = { tableView in
            AppStoreSearchResultCellController.register(for: tableView)
            tableView.showsVerticalScrollIndicator = false
        }
        return (sut, list)
    }
    
    private func emptyRecentTerms() -> [TableCellController] {
        []
    }
    
    private func recentTerms() -> [TableCellController] {
        let titleCellController = AppStoreRecentSearchTitleCellController(viewModel: "a title")
        let termCellController0 = AppStoreRecentSearchTermCellController(
            viewModel: AppStoreRecentSearchTermViewModel(term: "a term0"),
            selection: {_ in }
        )
        let termCellController1 = AppStoreRecentSearchTermCellController(
            viewModel: AppStoreRecentSearchTermViewModel(term: "a term1"),
            selection: {_ in }
        )
        let termCellController2 = AppStoreRecentSearchTermCellController(
            viewModel: AppStoreRecentSearchTermViewModel(term: "a term2"),
            selection: {_ in }
        )
        return [titleCellController, termCellController0, termCellController1, termCellController2].map(TableCellController.init)
    }
    
    private func matchedRecentTerms() -> [TableCellController] {
        let termCellController0 = AppStoreRecentSearchTermCellController(
            viewModel: AppStoreRecentSearchTermViewModel(
                isMatchedRecent: true,
                term: "a matched term0"
            ),
            selection: {_ in}
        )
        let termCellController1 = AppStoreRecentSearchTermCellController(
            viewModel: AppStoreRecentSearchTermViewModel(
                isMatchedRecent: true,
                term: "a matched term1"
            ),
            selection: {_ in}
        )
        return [termCellController0, termCellController1].map(TableCellController.init)
    }
    
    private func searchResults() -> [TableCellController] {
        let galleryCell0 = AppGalleryCellController(requestImage: {}, cancelRequestImage: {})
        let galleryCell1 = AppGalleryCellController(requestImage: {}, cancelRequestImage: {})
        let galleryCell2 = AppGalleryCellController(requestImage: {}, cancelRequestImage: {})
        let gallery = [galleryCell0, galleryCell1, galleryCell2].map(CellController.init)
        let view0 = AppStoreSearchResultCellController(
            viewModel: AppStoreSearchResultViewModel(
                title: "a title0",
                seller: "a seller0",
                ratings: (3, 0.40),
                numberOfRatingsText: "1.1만"
            ),
            galleryCellControllers: gallery,
            requestLogoImage: {},
            cancelRequestLogoImage: {},
            selection: {}
        )
        let view1 = AppStoreSearchResultCellController(
            viewModel: AppStoreSearchResultViewModel(
                title: "a title1",
                seller: "a seller1",
                ratings: (4, 0.44),
                numberOfRatingsText: "3.7천"
            ),
            galleryCellControllers: gallery,
            requestLogoImage: {},
            cancelRequestLogoImage: {},
            selection: {}
        )
        return [view0, view1].map(TableCellController.init)
    }
}
