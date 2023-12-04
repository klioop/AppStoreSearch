//
//  RecentSearchTermViewAdapter.swift
//  AppStoreSearchApp
//
//  Created by Lee Sam on 2023/09/18.
//

import UIKit
import AppStoreSearch
import AppStoreSearchiOS

final class RecentSearchTermViewAdapter: ResourceView {
    
    private weak var controller: ListViewController?
    private let selection: (SearchTerm) -> Void
    
    init(controller: ListViewController, selection: @escaping (SearchTerm) -> Void) {
        self.controller = controller
        self.selection = selection
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
                AppStoreRecentSearchTermCellController(
                    viewModel: AppStoreRecentSearchTermPresenter.map(term),
                    selection: { [weak self] in
                        self?.selection(SearchTerm(term: $0))
                        self?.controller?.topView.endEditing(true)
                    }
                )
            )
        }
        let termsCellControllers = terms.map(TableCellController.init)
        
        controller.display([titleCellController], termsCellControllers)
    }
}

private extension UIViewController {
    var topView: UIView {
        view.topView
    }
}

private extension UIView {
    var topView: UIView {
        superview ?? self
    }
}
