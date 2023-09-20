//
//  AppTitlePresenter.swift
//  AppStoreSearch
//
//  Created by Lee Sam on 2023/09/20.
//

import Foundation

public final class AppTitlePresenter {
    private init() {}
    
    public static func map(_ app: App) -> AppTitleViewModel {
        AppTitleViewModel(title: app.title, seller: app.seller)
    }
}
