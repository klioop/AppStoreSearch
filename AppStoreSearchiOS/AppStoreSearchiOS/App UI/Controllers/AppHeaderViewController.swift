//
//  AppHeaderViewController.swift
//  AppStoreSearchiOS
//
//  Created by Lee Sam on 2023/09/17.
//

import UIKit

public final class AppHeaderViewController {
    private let callback: () -> Void
    
    public init(callback: @escaping () -> Void) {
        self.callback = callback
    }
    
    public func view() -> AppHeaderView {
        let view = AppHeaderView()
        view.onTap = callback
        return view
    }
}
