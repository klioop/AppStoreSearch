//
//  UICollectionView+dequeueing.swift
//  Teuida
//
//  Created by Lee Sam on 2022/11/17.
//  Copyright © 2022 Teuida. All rights reserved.
//

import UIKit

extension UICollectionView {
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        let identifier = String(describing: T.self)
        return dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! T
    }
}
