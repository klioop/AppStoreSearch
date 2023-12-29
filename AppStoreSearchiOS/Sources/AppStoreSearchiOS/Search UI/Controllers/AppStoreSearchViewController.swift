//
//  AppStoreSearchViewController.swift
//  AppStoreSearchiOS
//
//  Created by Lee Sam on 2023/09/16.
//

import Foundation
import AppStoreSearch

public final class AppStoreSearchViewController {
    private let viewModel: AppStoreSearchViewModel
    private let searchCallback: (String) -> Void
    private let textChangeCallback: (String) -> Void
    private let cancelCallback: () -> Void
    
    public init(
        viewModel: AppStoreSearchViewModel,
        searchCallback: @escaping (String) -> Void,
        textChangeCallback: @escaping (String) -> Void,
        cancelCallback: @escaping () -> Void
    ) {
        self.viewModel = viewModel
        self.searchCallback = searchCallback
        self.textChangeCallback = textChangeCallback
        self.cancelCallback = cancelCallback
    }
    
    public func view() -> AppStoreSearchView {
        let view = AppStoreSearchView()
        view.title = viewModel.title
        view.placeholder = viewModel.placeholder
        view.onTapSearch = searchCallback
        view.onTextChange = textChangeCallback
        view.onTapCancel = cancelCallback
        return view
    }
}
