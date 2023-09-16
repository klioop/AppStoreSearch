//
//  CollectionListViewController.swift
//  Teuida
//
//  Created by Lee Sam on 2022/11/17.
//  Copyright © 2022 Teuida. All rights reserved.
//

import UIKit

public final class CollectionListViewController: UICollectionViewController {
    private var refreshController: RefreshController?
    
    public convenience init(refreshController: RefreshController? = .none) {
        self.init(collectionViewLayout: UICollectionViewLayout())
        self.refreshController = refreshController
    }
    
    public convenience init() {
        self.init(collectionViewLayout: UICollectionViewLayout())
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .systemBackground
        collectionView.refreshControl = refreshController?.view
        collectionView.dataSource = dataSource
        configure?(collectionView)
    }
    
    public var refresh: (() -> Void)? {
        refreshController?.refresh
    }
    
    public var configure: ((UICollectionView) -> Void)?
    
    public private(set) lazy var dataSource: UICollectionViewDiffableDataSource<Int, CellController> = {
        let ds = UICollectionViewDiffableDataSource<Int, CellController>(collectionView: collectionView) {
            collectionView, indexPath, cellController in
            cellController.dataSource.collectionView(collectionView, cellForItemAt: indexPath)
        }
        return ds
    }()
    
    public func display(_ cellControllers: [CellController]..., completion: (() -> Void)? = .none) {
        var snapShot = NSDiffableDataSourceSnapshot<Int, CellController>()
        cellControllers.enumerated().forEach { section, cellControllers in
            snapShot.appendSections([section])
            snapShot.appendItems(cellControllers, toSection: section)
        }
        if #available(iOS 15.0, *) {
            dataSource.applySnapshotUsingReloadData(snapShot, completion: completion)
        } else {
            dataSource.apply(snapShot, completion: completion)
        }
    }
    
    public func display(_ cellControllers: [[CellController]], completion: (() -> Void)? = .none) {
        var snapShot = NSDiffableDataSourceSnapshot<Int, CellController>()
        cellControllers.enumerated().forEach { section, cellControllers in
            snapShot.appendSections([section])
            snapShot.appendItems(cellControllers, toSection: section)
        }
        if #available(iOS 15.0, *) {
            dataSource.applySnapshotUsingReloadData(snapShot, completion: completion)
        } else {
            dataSource.apply(snapShot, completion: completion)
        }
    }
    
    public override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        cellController(for: indexPath)?.delegate?.collectionView?(collectionView, didSelectItemAt: indexPath)
    }
    
    public override func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let dl = cellController(for: indexPath)
        dl?.delegate?.collectionView?(collectionView, didEndDisplaying: cell, forItemAt: indexPath)
    }
    
    // MARK: - Helpers
    
    private func cellController(for indexPath: IndexPath) -> CellController? {
        dataSource.itemIdentifier(for: indexPath)
    }
}
