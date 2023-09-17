//
//  TableCellController.swift
//  Teuida
//
//  Created by Lee Sam on 2022/11/20.
//  Copyright © 2022 Teuida. All rights reserved.
//

import UIKit

public struct TableCellController {
    let id: AnyHashable
    let dataSource: UITableViewDataSource
    let delegate: UITableViewDelegate?
    
    public init(id: AnyHashable, _ dataSource: UITableViewDataSource & UITableViewDelegate) {
        self.id = id
        self.dataSource = dataSource
        self.delegate = dataSource
    }
    
    public init(id: AnyHashable, _ dataSource: UITableViewDataSource) {
        self.id = id
        self.dataSource = dataSource
        self.delegate = dataSource as? UITableViewDelegate
    }
    
    public init(_ dataSource: UITableViewDataSource) {
        self.init(id: UUID(), dataSource)
    }
}

extension TableCellController: Equatable {
    public static func == (lhs: TableCellController, rhs: TableCellController) -> Bool {
        lhs.id == rhs.id
    }
}

extension TableCellController: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
