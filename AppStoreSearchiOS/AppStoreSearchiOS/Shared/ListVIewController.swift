//
//  ListViewController.swift
//  Teuida
//
//  Created by Lee Sam on 2022/11/21.
//  Copyright © 2022 Teuida. All rights reserved.
//

import UIKit

public final class ListViewController: UITableViewController {
    private var refreshController: RefreshController?
    
    convenience init(refreshController: RefreshController, style: UITableView.Style = .plain) {
        self.init(style: style)
        self.refreshController = refreshController
    }
    
    public var configure: ((UITableView) -> Void)?
    
    private(set) public lazy var dataSource = UITableViewDiffableDataSource<Int, TableCellController>(tableView: tableView) {
        tableView, indexPath, cellController in
        cellController.dataSource.tableView(tableView, cellForRowAt: indexPath)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataSource
        refreshControl = refreshController?.view
        configure?(tableView)
    }
    
    public var refresh: (() -> Void)? {
        refreshController?.onRefresh
    }
    
    public func display(_ cellControllers: [TableCellController]..., completion: (() -> Void)? = nil) {
        var snapShot = NSDiffableDataSourceSnapshot<Int, TableCellController>()
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
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cellController(for: indexPath)?.delegate?.tableView?(tableView, didSelectRowAt: indexPath)
    }
    
    public override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cellController(for: indexPath)?.delegate?.tableView?(tableView, didEndDisplaying: cell, forRowAt: indexPath)
    }
    
    // MARK: - Helpers
    
    private func cellController(for indexPath: IndexPath) -> TableCellController? {
        dataSource.itemIdentifier(for: indexPath)
    }
}
