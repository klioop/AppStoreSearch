//
//  AppStoreRecentSearchTermCellController.swift
//  AppStoreSearchiOS
//
//  Created by Lee Sam on 2023/09/16.
//

import UIKit
import AppStoreSearch

public final class AppStoreRecentSearchTermCellController: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    private let viewModel: AppStoreRecentSearchTermViewModel
    private let selection: (String) -> Void
    
    public init(viewModel: AppStoreRecentSearchTermViewModel, selection: @escaping (String) -> Void) {
        self.viewModel = viewModel
        self.selection = selection
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AppStoreRecentSearchTermCell()
        cell.isMatchedRecent = viewModel.isMatchedRecent
        cell.term = viewModel.term
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selection(viewModel.term)
    }
}
