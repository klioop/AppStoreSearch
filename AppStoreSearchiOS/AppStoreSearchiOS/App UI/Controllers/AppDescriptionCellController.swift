//
//  AppDescriptionCellController.swift
//  AppStoreSearchiOS
//
//  Created by Lee Sam on 2023/09/17.
//

import UIKit

public final class AppDescriptionCellController: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    private let viewModel: AppDescriptionViewModel
    
    public init(viewModel: AppDescriptionViewModel) {
        self.viewModel = viewModel
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AppDescriptionCell()
        cell.ratingText = viewModel.ratingText
        cell.numberOfRatingText = viewModel.numberOfRatingText
        cell.rating = (viewModel.rating.int, CGFloat(viewModel.rating.decimal))
        cell.rankingTitle = viewModel.rankingText
        cell.rankingDescription = viewModel.rankDescription
        cell.ageTitle = viewModel.ageText
        cell.ageDescription = viewModel.ageDescription
        return cell
    }
}
