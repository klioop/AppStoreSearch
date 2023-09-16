//
//  RefreshController.swift
//  Teuida
//
//  Created by Lee Sam on 2022/11/30.
//  Copyright © 2022 Teuida. All rights reserved.
//

import UIKit

public final class RefreshController {
    lazy var view: UIRefreshControl = {
        let view = UIRefreshControl()
        view.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return view
    }()
    
    public init() {}
    
    public var onRefresh: (() -> Void)?
    
    @objc func refresh() {
        onRefresh?()
    }
}
