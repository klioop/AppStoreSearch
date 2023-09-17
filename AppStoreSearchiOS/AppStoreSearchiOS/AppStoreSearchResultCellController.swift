//
//  AppStoreSearchResultCellController.swift
//  AppStoreSearchiOS
//
//  Created by Lee Sam on 2023/09/16.
//

import UIKit

public struct AppStoreSearchResultViewModel {
    public let title: String
    public let description: String
    public let ratings: (int: Int, decimal: CGFloat)
    public let numberOfRatingsText: String
    public let logoImage: URL
    public let images: [URL]
    
    public init(title: String, description: String, ratings: (int: Int, decimal: CGFloat), numberOfRatingsText: String, logoImage: URL, images: [URL]) {
        self.title = title
        self.description = description
        self.ratings = ratings
        self.numberOfRatingsText = numberOfRatingsText
        self.logoImage = logoImage
        self.images = images
    }
}

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
