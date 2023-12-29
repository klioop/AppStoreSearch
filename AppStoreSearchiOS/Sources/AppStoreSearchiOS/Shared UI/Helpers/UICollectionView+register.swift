//
//  UICollectionView+register.swift
//  Teuida
//
//  Created by Lee Sam on 2022/11/17.
//  Copyright © 2022 Teuida. All rights reserved.
//

import UIKit

public extension UICollectionView {
    func register<T: UICollectionViewCell>(_ cellType: T.Type) {
        let identifier = String(describing: cellType)
        register(cellType, forCellWithReuseIdentifier: identifier)
    }
}
