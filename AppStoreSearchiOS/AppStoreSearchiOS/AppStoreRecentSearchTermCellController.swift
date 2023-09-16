//
//  AppStoreRecentSearchTermCellController.swift
//  AppStoreSearchiOS
//
//  Created by Lee Sam on 2023/09/16.
//

import UIKit

public struct AppStoreRecentSearchTermViewModel {
    public let isRecentMatched: Bool
    public let term: String
    
    public init(isRecentMatched: Bool = false, term: String) {
        self.isRecentMatched = isRecentMatched
        self.term = term
    }
}

public final class AppStoreRecentSearchTermCellController: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    private let viewModel: AppStoreRecentSearchTermViewModel
    
    public init(viewModel: AppStoreRecentSearchTermViewModel) {
        self.viewModel = viewModel
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AppStoreRecentSearchTermCell()
        cell.isRecentMatched = viewModel.isRecentMatched
        cell.term = viewModel.term
        return cell
    }
}
