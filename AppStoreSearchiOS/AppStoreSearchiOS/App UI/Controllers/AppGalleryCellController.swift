//
//  AppGalleryCellController.swift
//  AppStoreSearchiOS
//
//  Created by Lee Sam on 2023/09/17.
//

import UIKit
import AppStoreSearch

public final class AppGalleryCellController: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    
    private var cell: AppGalleryCell?
    
    private let requestImage: () -> Void
    private let cancelRequestImage: () -> Void
    
    public init(requestImage: @escaping () -> Void, cancelRequestImage: @escaping () -> Void) {
        self.requestImage = requestImage
        self.cancelRequestImage = cancelRequestImage
    }
    
    public static func register(for collectionView: UICollectionView) {
        collectionView.register(AppGalleryCell.self)
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        self.cell = collectionView.dequeueReusableCell(for: indexPath)
        requestImage()
        return cell!
    }
    
    public func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cancelRequestImage()
        releaseCellForReuse()
    }
    
    // MARK: - Helpers
    
    private func releaseCellForReuse() {
        self.cell = nil
    }
}

extension AppGalleryCellController: ResourceView, ResourceLoadingView {
    public typealias ResourceViewModel = UIImage
    
    public func display(_ viewModel: UIImage) {
        cell?.imageView.image = viewModel
    }
    
    public func display(_ viewModel: ResourceLoadingViewModel) {
        cell?.imageContainer.isShimmering = viewModel.isLoading
    }
}
