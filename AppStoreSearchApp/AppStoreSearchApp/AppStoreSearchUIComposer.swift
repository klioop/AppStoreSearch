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
    
    typealias SearchTermLoadPresentationAdapter = LoadResourcePresentationAdapter<Void, [SearchTerm], RecentSearchTermViewAdapter>
    
    public static func composedWith(termLoader: @escaping () -> AnyPublisher<[SearchTerm], Error>) -> AppStoreSearchContainerViewController {
        let searchTermPresentationAdapter = SearchTermLoadPresentationAdapter(loader: termLoader)
        let searchViewController = AppStoreSearchViewController(viewModel: AppStoreSearchPresenter.viewModel())
        let listViewController = ListViewController()
        let container = AppStoreSearchContainerViewController(
            searchView: searchViewController.view(),
            listViewController: listViewController
        )
        searchTermPresentationAdapter.presenter = LoadResourcePresenter(
            resourceView: RecentSearchTermViewAdapter(controller: listViewController),
            loadingView: .none,
            errorView: .none
        )
        listViewController.configure = {_ in
            searchTermPresentationAdapter.loadResource(with: ())
        }
        return container
    }
}
