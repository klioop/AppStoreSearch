//
//  AppStoreSearchResultCellController.swift
//  AppStoreSearchiOS
//
//  Created by Lee Sam on 2023/09/16.
//

import UIKit
import AppStoreSearch

public final class AppStoreSearchResultCellController: NSObject, UITableViewDataSource, UITableViewDelegate {
    private var cell: AppStoreSearchResultCell?
    
    private let viewModel: AppStoreSearchResultViewModel
    
    public init(viewModel: AppStoreSearchResultViewModel) {
        self.viewModel = viewModel
    }
    
    public static func register(for tableView: UITableView) {
        tableView.register(AppStoreSearchResultCell.self)
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.cell = tableView.dequeueReusableCell()
        cell?.title = viewModel.title
        cell?.descriptionText = viewModel.description
        cell?.ratings = viewModel.ratings
        cell?.numberOfRatings = viewModel.numberOfRatingsText
        return cell!
    }
}
