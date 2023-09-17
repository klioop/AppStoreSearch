//
//  AppGalleryCellController.swift
//  AppStoreSearchiOS
//
//  Created by Lee Sam on 2023/09/17.
//

import UIKit

public final class AppGalleryCellController: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    public typealias ViewModel = URL
    
    private var cell: AppGalleryCell?
    
    private let viewModel: ViewModel
    
    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    public static func register(for collectionView: UICollectionView) {
        collectionView.register(AppGalleryCell.self)
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        self.cell = collectionView.dequeueReusableCell(for: indexPath)
        return cell!
    }
}
