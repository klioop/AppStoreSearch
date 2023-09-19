//
//  AppStoreSearchUIComposer.swift
//  AppStoreSearchApp
//
//  Created by Lee Sam on 2023/09/18.
//

import Foundation
import Combine
import AppStoreSearch
import AppStoreSearchiOS

final class AppsViewAdapter: ResourceView {
    
    private weak var controller: ListViewController?
    
    init(controller: ListViewController) {
        self.controller = controller
    }
    
    func display(_ viewModel: [App]) {}
}


public final class AppStoreSearchUIComposer {
    private init() {}
    
    private typealias RecentSearchTermLoadPresentationAdapter = LoadResourcePresentationAdapter<Void, [SearchTerm], RecentSearchTermViewAdapter>
    private typealias MatchedSearchTermLoadPresentationAdapter = LoadResourcePresentationAdapter<SearchTerm, [SearchTerm], MatchedSearchTermsViewAdapter>
    private typealias AppsLoadPresentationAdapter = LoadResourcePresentationAdapter<SearchTerm, [App], AppsViewAdapter>
    
    public static func composedWith(
        recentTermsLoader: @escaping () -> AnyPublisher<[SearchTerm], Error>,
        matchedTermsLoader: @escaping (SearchTerm) -> AnyPublisher<[SearchTerm], Error>,
        appsLoader: @escaping (SearchTerm) -> AnyPublisher<[App], Error>
    ) -> AppStoreSearchContainerViewController {
        let recentTermsPresentationAdapter = RecentSearchTermLoadPresentationAdapter(loader: recentTermsLoader)
        let matchedTermsPresentationAdapter = MatchedSearchTermLoadPresentationAdapter(loader: matchedTermsLoader)
        let appsPresentationAdapter = AppsLoadPresentationAdapter(loader: appsLoader)
        let searchViewController = AppStoreSearchViewController(
            viewModel: AppStoreSearchPresenter.viewModel(),
            searchCallback: {
                appsPresentationAdapter.loadResource(with: SearchTerm(term: $0))
            },
            textChangeCallback: {
                textChangeCallback(
                    recentTermsPresentationAdapter: recentTermsPresentationAdapter,
                    matchedTermsPresentationAdapter: matchedTermsPresentationAdapter,
                    upon: $0
                )
            },
            cancelCallback: {
                recentTermsPresentationAdapter.loadResource(with: ())
            }
        )
        let listViewController = ListViewController()
        let container = AppStoreSearchContainerViewController(
            searchView: searchViewController.view(),
            listViewController: listViewController
        )
        recentTermsPresentationAdapter.presenter = LoadResourcePresenter(
            resourceView: RecentSearchTermViewAdapter(controller: listViewController),
            loadingView: .none,
            errorView: .none
        )
        matchedTermsPresentationAdapter.presenter = LoadResourcePresenter(
            resourceView: MatchedSearchTermsViewAdapter(controller: listViewController),
            loadingView: .none,
            errorView: .none
        )
        listViewController.configure = {_ in
            recentTermsPresentationAdapter.loadResource(with: ())
        }
        return container
    }
    
    // MARK: - Helpers
    
    private static func textChangeCallback(
        recentTermsPresentationAdapter: RecentSearchTermLoadPresentationAdapter,
        matchedTermsPresentationAdapter: MatchedSearchTermLoadPresentationAdapter,
        upon text: String
    ) {
        if text.isEmpty {
            recentTermsPresentationAdapter.loadResource(with: ())
        } else {
            matchedTermsPresentationAdapter.loadResource(with: SearchTerm(term: text))
        }
    }
}
