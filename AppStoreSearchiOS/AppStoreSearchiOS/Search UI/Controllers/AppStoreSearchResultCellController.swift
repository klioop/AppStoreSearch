//
//  AppStoreSearchResultCellController.swift
//  AppStoreSearchiOS
//
//  Created by Lee Sam on 2023/09/16.
//

import UIKit

public final class AppStoreSearchResultCellController: NSObject, UITableViewDataSource, UITableViewDelegate {
    private let viewModel: AppStoreSearchResultViewModel
    
    public init(viewModel: AppStoreSearchResultViewModel) {
        self.viewModel = viewModel
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AppStoreSearchResultCell()
        cell.title = viewModel.title
        cell.descriptionText = viewModel.description
        cell.ratings = viewModel.ratings
        cell.numberOfRatings = viewModel.numberOfRatingsText
        return cell
    }
}