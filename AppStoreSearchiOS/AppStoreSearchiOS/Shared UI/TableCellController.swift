//
//  TableCellController.swift
//
//  Created by Lee Sam
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
