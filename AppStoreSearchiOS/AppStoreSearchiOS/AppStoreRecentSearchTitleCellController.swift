//
//  AppStoreRecentSearchTitleCellController.swift
//  AppStoreSearchiOS
//
//  Created by Lee Sam on 2023/09/16.
//

import UIKit

public final class AppStoreRecentSearchTitleCellController: NSObject, UITableViewDataSource, UITableViewDelegate {
    public typealias Title = String
    
    private let viewModel: Title
    
    public init(viewModel: Title) {
        self.viewModel = viewModel
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AppStoreRecentSearchTitleCell()
        cell.title = viewModel
        return cell
    }
}
