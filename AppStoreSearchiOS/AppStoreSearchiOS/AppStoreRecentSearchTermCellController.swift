//
//  AppStoreRecentSearchTermCellController.swift
//  AppStoreSearchiOS
//
//  Created by Lee Sam on 2023/09/16.
//

import UIKit

public final class AppStoreRecentSearchTermCellController: NSObject, UITableViewDataSource, UITableViewDelegate {
    public typealias Term = String
    
    private let viewModel: Term
    
    public init(viewModel: Term) {
        self.viewModel = viewModel
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AppStoreRecentSearchTermCell()
        cell.term = viewModel
        return cell
    }
}
