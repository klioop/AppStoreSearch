//
//  ScreenSafeArea.swift
//  AppStoreSearchiOS
//
//  Created by Lee Sam on 2023/09/16.
//

import UIKit

struct ScreenSafeArea {
    static let top = UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
}
