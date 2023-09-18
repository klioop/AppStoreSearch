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

final class RecentSearchTermViewAdapter: ResourceView {
    
    private weak var controller: ListViewController?
    
    init(controller: ListViewController) {
        self.controller = controller
    }
    
    func display(_ viewModel: [SearchTerm]) {
        guard let controller else { return }
        
        let title = AppStoreRecentSearchTitleCellController(viewModel: "최근 검색어")
        let titleCellController = TableCellController(title)
        
        guard !viewModel.isEmpty else {
            return controller.display([titleCellController], [])
        }
        
        let terms = viewModel.map { term -> (SearchTerm, AppStoreRecentSearchTermCellController) in
            (
                term,
                AppStoreRecentSearchTermCellController(viewModel: AppStoreRecentSearchTermViewModel(term: term.term))
            )
        }
        
        let termsCellControllers = terms.map(TableCellController.init)
        
        controller.display([titleCellController], termsCellControllers)
    }
}

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
