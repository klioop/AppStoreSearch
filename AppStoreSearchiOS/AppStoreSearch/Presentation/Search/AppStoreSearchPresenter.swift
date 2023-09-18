//
//  AppStoreSearchPresenter.swift
//  AppStoreSearch
//
//  Created by Lee Sam on 2023/09/18.
//

import Foundation

public final class AppStoreSearchPresenter {
    private init() {}
    
    public static func viewModel() -> AppStoreSearchViewModel {
        AppStoreSearchViewModel(title: "검색", placeholder: "게임, 앱, 스토리 등")
    }
}
