//
//  AppPreviewCellController.swift
//  AppStoreSearchiOS
//
//  Created by Lee Sam on 2023/09/17.
//

import UIKit

public final class AppPreviewCellController: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    private lazy var galleryView: CollectionListViewController = {
        let gallery = CollectionListViewController()
        gallery.configure = { collectionView in
            collectionView.collectionViewLayout = AppGalleryLayout.layout()
            AppGalleryCellController.register(for: collectionView)
        }
        gallery.display(galleryCellControllers)
        return gallery
    }()
    
    private let galleryCellControllers: [CellController]
    
    public init(galleryCellControllers: [CellController]) {
        self.galleryCellControllers = galleryCellControllers
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AppPreviewCell()
        cell.title = "미리보기"
        cell.gallery = galleryView.collectionView
        return cell
    }
}
