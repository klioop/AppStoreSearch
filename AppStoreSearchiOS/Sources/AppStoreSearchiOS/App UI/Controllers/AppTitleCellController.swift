//
//  AppTitleCellController.swift
//  AppStoreSearchiOS
//
//  Created by Lee Sam on 2023/09/17.
//

import UIKit
import AppStoreSearch

public final class AppTitleCellController: NSObject, UITableViewDataSource, UITableViewDelegate {
    private let cell = AppTitleCell()
    
    private let viewModel: AppTitleViewModel
    private let requestLogoImage: () -> Void
    
    public init(viewModel: AppTitleViewModel, requestLogoImage: @escaping () -> Void) {
        self.viewModel = viewModel
        self.requestLogoImage = requestLogoImage
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cell.title = viewModel.title
        cell.descriptionText = viewModel.seller
        requestLogoImage()
        return cell
    }
}

extension AppTitleCellController: ResourceView, ResourceLoadingView {
    public typealias ResourceViewModel = UIImage
    
    public func display(_ viewModel: UIImage) {
        cell.logoImageView.image = viewModel
    }
    
    public func display(_ viewModel: ResourceLoadingViewModel) {
        cell.logoContainer.isShimmering = viewModel.isLoading
    }
}
