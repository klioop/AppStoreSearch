//
//  ListViewController+testHelpers.swift
//  AppStoreSearchAppTests
//
//  Created by Lee Sam on 2023/09/20.
//

import XCTest
import AppStoreSearchiOS

extension ListViewController {
    
    func numberOfViews(in section: Int) -> Int {
        tableView.numberOfRows(inSection: section)
    }
    
    func cell(in row: Int, section: Int) -> UITableViewCell? {
        let ds = tableView.dataSource
        let indexPath0 = IndexPath(row: row, section: section)
        return ds?.tableView(tableView, cellForRowAt: indexPath0)
    }
}
