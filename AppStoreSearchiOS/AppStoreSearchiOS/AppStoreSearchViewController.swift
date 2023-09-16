//
//  AppStoreSearchViewController.swift
//  AppStoreSearchiOS
//
//  Created by Lee Sam on 2023/09/16.
//

import Foundation

public final class AppStoreSearchViewController {
    private let viewModel: AppStoreSearchViewModel
    
    public init(viewModel: AppStoreSearchViewModel) {
        self.viewModel = viewModel
    }
    
    public func view() -> AppStoreSearchView {
        let view = AppStoreSearchView()
        view.title = viewModel.title
        view.placeholder = viewModel.placeholder
        return view
    }
}
