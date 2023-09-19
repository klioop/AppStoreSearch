//
//  AppNewFeatureCellController.swift
//  AppStoreSearchiOS
//
//  Created by Lee Sam on 2023/09/17.
//

import UIKit
import AppStoreSearch

public final class AppNewFeatureCellController: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    private let viewModel: AppNewFeatureViewModel
    
    public init(viewModel: AppNewFeatureViewModel) {
        self.viewModel = viewModel
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AppNewFeatureCell()
        cell.title = viewModel.title
        cell.version = viewModel.version
        cell.firstDescription = viewModel.firstDescription
        cell.secondDescription = viewModel.secondDescription
        cell.onTap = {
            tableView.beginUpdates()
            tableView.endUpdates()
        }
        return cell
    }
}
