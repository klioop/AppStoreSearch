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
    
    public init(viewModel: AppStoreSearchResultViewModel, galleryCellControllers: [CellController]) {
        self.viewModel = viewModel
        self.galleryCellControllers = galleryCellControllers
    }
    
    public static func register(for tableView: UITableView) {
        tableView.register(AppStoreSearchResultCell.self)
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.cell = tableView.dequeueReusableCell()
        cell?.gallery = galleryView.view
        cell?.title = viewModel.title
        cell?.seller = viewModel.seller
        cell?.ratings = viewModel.ratings
        cell?.numberOfRatings = viewModel.numberOfRatingsText
        return cell!
    }
}
