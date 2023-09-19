//
//  MatchedSearchTermsViewAdapter.swift
//  AppStoreSearchApp
//
//  Created by Lee Sam on 2023/09/19.
//

import Foundation
import AppStoreSearch
import AppStoreSearchiOS

final class MatchedSearchTermsViewAdapter: ResourceView {
    
    private weak var controller: ListViewController?
    private let selection: (SearchTerm) -> Void
    
    init(controller: ListViewController, selection: @escaping (SearchTerm) -> Void) {
        self.controller = controller
        self.selection = selection
    }
    
    func display(_ viewModel: [SearchTerm]) {
        let cellControllers = viewModel.map { term -> (SearchTerm, AppStoreRecentSearchTermCellController) in
            return (
                term,
                AppStoreRecentSearchTermCellController(
                    viewModel: AppStoreRecentSearchTermPresenter.mapToMatched(term),
                    selection: { [weak self] in
                        self?.selection(SearchTerm(term: $0))
                    }
                )
            )
        }
            .map(TableCellController.init)
        
        controller?.display(cellControllers)
    }
}
