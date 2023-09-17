//
//  AppDescriptionCellController.swift
//  AppStoreSearchiOS
//
//  Created by Lee Sam on 2023/09/17.
//

import UIKit

public struct AppDescriptionViewModel {
    public let ratingText: String
    public let numberOfRatingText: String
    public let rating: (int: Int, decimal: Double)
    
    public init(ratingText: String, numberOfRatingText: String, rating: (int: Int, decimal: Double)) {
        self.ratingText = ratingText
        self.numberOfRatingText = numberOfRatingText
        self.rating = rating
    }
}

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
        return cell
    }
}
