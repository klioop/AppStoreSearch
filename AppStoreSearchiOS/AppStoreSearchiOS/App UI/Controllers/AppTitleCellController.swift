//
//  AppTitleCellController.swift
//  AppStoreSearchiOS
//
//  Created by Lee Sam on 2023/09/17.
//

import UIKit
import AppStoreSearch

public final class AppTitleCellController: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    private let viewModel: AppTitleViewModel
    
    public init(viewModel: AppTitleViewModel) {
        self.viewModel = viewModel
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AppTitleCell()
        cell.title = viewModel.title
        cell.descriptionText = viewModel.description
        return cell
    }
}
