//
//  UITableView+register.swift
//  Teuida
//
//  Created by Lee Sam on 2022/11/21.
//  Copyright © 2022 Teuida. All rights reserved.
//

import UIKit

public extension UITableView {
    func register<T: UITableViewCell>(_ cellType: T.Type) {
        let identifier = String(describing: cellType)
        register(cellType, forCellReuseIdentifier: identifier)
    }
}
