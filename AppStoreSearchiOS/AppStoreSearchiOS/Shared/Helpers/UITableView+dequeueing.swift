//
//  UITableView+dequeueing.swift
//  Teuida
//
//  Created by Lee Sam on 2022/11/21.
//  Copyright © 2022 Teuida. All rights reserved.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>() -> T {
        let identifier = String(describing: T.self)
        return dequeueReusableCell(withIdentifier: identifier) as! T
    }
}
