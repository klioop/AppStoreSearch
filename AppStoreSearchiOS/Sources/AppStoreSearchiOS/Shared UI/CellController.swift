//
//  CellController.swift
//
//  Created by Lee Sam
//

import UIKit

public struct CellController {
    let id: AnyHashable
    let dataSource: UICollectionViewDataSource
    let delegate: UICollectionViewDelegate?
    let dataSourcePrefetching: UICollectionViewDataSourcePrefetching?
    
    public init(id: AnyHashable, _ dataSource: UICollectionViewDataSource & UICollectionViewDelegate & UICollectionViewDataSourcePrefetching) {
        self.id = id
        self.dataSource = dataSource
        self.delegate = dataSource
        self.dataSourcePrefetching = dataSource
    }
    
    public init(id: AnyHashable, _ dataSource: UICollectionViewDataSource) {
        self.id = id
        self.dataSource = dataSource
        self.delegate = dataSource as? UICollectionViewDelegate
        self.dataSourcePrefetching = dataSource as? UICollectionViewDataSourcePrefetching
    }
    
    public init(_ dataSource: UICollectionViewDataSource) {
        self.init(id: UUID(), dataSource)
    }
}

extension CellController: Equatable {
    public static func == (lhs: CellController, rhs: CellController) -> Bool {
        lhs.id == rhs.id
    }
}

extension CellController: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
