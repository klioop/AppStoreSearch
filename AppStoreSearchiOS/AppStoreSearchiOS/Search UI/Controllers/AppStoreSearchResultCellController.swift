//
//  AppStoreSearchResultCellController.swift
//  AppStoreSearchiOS
//
//  Created by Lee Sam on 2023/09/16.
//

import UIKit
import AppStoreSearch

public final class AppStoreSearchResultCellController: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    private lazy var galleryView: CollectionListViewController = {
        let gallery = CollectionListViewController()
        gallery.configure = { collectionView in
            collectionView.collectionViewLayout = AppGalleryOnSearchLayout.layout()
            AppGalleryCellController.register(for: collectionView)
        }
        gallery.display(galleryCellControllers)
        return gallery
    }()
    
    private var cell: AppStoreSearchResultCell?
    
    private let viewModel: AppStoreSearchResultViewModel
    private let galleryCellControllers: [CellController]
    private let requestLogoImage: () -> Void
    private let cancelRequestLogoImage: () -> Void
    private let selection: () -> Void
    
    public init(
        viewModel: AppStoreSearchResultViewModel,
        galleryCellControllers: [CellController],
        requestLogoImage: @escaping () -> Void,
        cancelRequestLogoImage: @escaping () -> Void,
        selection: @escaping () -> Void
    ) {
        self.viewModel = viewModel
        self.galleryCellControllers = galleryCellControllers
        self.requestLogoImage = requestLogoImage
        self.cancelRequestLogoImage = cancelRequestLogoImage
        self.selection = selection
    }
    
    public static func register(for tableView: UITableView) {
        tableView.register(AppStoreSearchResultCell.self)
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.cell = tableView.dequeueReusableCell()
        cell?.gallery = galleryView.collectionView
        cell?.title = viewModel.title
        cell?.seller = viewModel.seller
        cell?.ratings = viewModel.ratings
        cell?.numberOfRatings = viewModel.numberOfRatingsText
        requestLogoImage()
        return cell!
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selection()
    }
    
    public func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cancelRequestLogoImage()
        releaseCellForReuse()
    }
    
    // MARK: - Helpers
    
    private func releaseCellForReuse() {
        self.cell = nil
    }
}

extension AppStoreSearchResultCellController: ResourceView, ResourceLoadingView {
    public typealias ResourceViewModel = UIImage
    
    public func display(_ viewModel: UIImage) {
        cell?.logoImageView.image = viewModel
    }
    
    public func display(_ viewModel: ResourceLoadingViewModel) {
        cell?.logoContainer.isShimmering = viewModel.isLoading
    }
}
