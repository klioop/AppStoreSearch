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

public final class AppStoreSearchUIComposer {
    private init() {}
    
    private typealias RecentSearchTermLoadPresentationAdapter = LoadResourcePresentationAdapter<Void, [SearchTerm], RecentSearchTermViewAdapter>
    private typealias MatchedSearchTermLoadPresentationAdapter = LoadResourcePresentationAdapter<SearchTerm, [SearchTerm], MatchedSearchTermsViewAdapter>
    private typealias AppsLoadPresentationAdapter = LoadResourcePresentationAdapter<SearchTerm, [App], AppsFoundViewAdapter>
    
    public static func composedWith(
        recentTermsLoader: @escaping () -> AnyPublisher<[SearchTerm], Error>,
        matchedTermsLoader: @escaping (SearchTerm) -> AnyPublisher<[SearchTerm], Error>,
        appsLoader: @escaping (SearchTerm) -> AnyPublisher<[App], Error>,
        imageDataLoader: @escaping (URL) -> AnyPublisher<Data, Error>,
        save: @escaping (SearchTerm) -> Void,
        selection: @escaping (App) -> Void
    ) -> AppStoreSearchContainerViewController {
        let recentTermsPresentationAdapter = RecentSearchTermLoadPresentationAdapter(loader: recentTermsLoader)
        let matchedTermsPresentationAdapter = MatchedSearchTermLoadPresentationAdapter(loader: matchedTermsLoader)
        let appsPresentationAdapter = AppsLoadPresentationAdapter(loader: appsLoader)
        let searchViewController = AppStoreSearchViewController(
            viewModel: AppStoreSearchPresenter.viewModel(),
            searchCallback: {
                let term = SearchTerm(term: $0)
                save(term)
                appsPresentationAdapter.loadResource(with: term)
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
            resourceView: RecentSearchTermViewAdapter(
                controller: listViewController,
                selection: appsPresentationAdapter.loadResource
            ),
            loadingView: .none,
            errorView: .none
        )
        matchedTermsPresentationAdapter.presenter = LoadResourcePresenter(
            resourceView: MatchedSearchTermsViewAdapter(
                controller: listViewController,
                selection: appsPresentationAdapter.loadResource
            ),
            loadingView: .none,
            errorView: .none
        )
        appsPresentationAdapter.presenter = LoadResourcePresenter(
            resourceView: AppsFoundViewAdapter(
                controller: listViewController,
                imageDataLoader: imageDataLoader,
                selection: selection
            ),
            loadingView: .none,
            errorView: .none
        )
        listViewController.configure = { tableView in
            AppStoreSearchResultCellController.register(for: tableView)
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
