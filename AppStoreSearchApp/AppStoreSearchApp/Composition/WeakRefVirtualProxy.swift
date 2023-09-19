//
//  WeakRefVirtualProxy.swift
//  AppStoreSearchApp
//
//  Created by Lee Sam on 2023/09/19.
//

import UIKit
import AppStoreSearch

final class WeakRefVirtualProxy<T: AnyObject> {
    private weak var object: T?
    
    public init(_ object: T) {
        self.object = object
    }
}

extension WeakRefVirtualProxy: ResourceView where T: ResourceView, T.ResourceViewModel == UIImage {
    func display(_ resourceViewModel: UIImage) {
        object?.display(resourceViewModel)
    }
}

extension WeakRefVirtualProxy: ResourceLoadingView where T: ResourceLoadingView {
    func display(_ viewModel: ResourceLoadingViewModel) {
        object?.display(viewModel)
    }
}
