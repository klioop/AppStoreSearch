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
    
    init(controller: ListViewController) {
        self.controller = controller
    }
    
    func display(_ viewModel: [SearchTerm]) {
        let cellControllers = viewModel.map { term -> (SearchTerm, AppStoreRecentSearchTermCellController) in
            return (
                term,
                AppStoreRecentSearchTermCellController(viewModel: AppStoreRecentSearchTermViewModel(isMatchedRecent: true, term: term.term))
            )
        }
            .map(TableCellController.init)
        
        controller?.display(cellControllers)
    }
}
