//
//  LoadResourcePresenter.swift
//  AppStoreSearch
//
//  Created by Lee Sam on 2023/09/18.
//

import Foundation

public protocol ResourceView {
    associatedtype ResourceViewModel
    
    func display(_ resourceViewModel: ResourceViewModel)
}

public final class LoadResourcePresenter<Resource, View: ResourceView> {
    public typealias Mapper = (Resource) throws -> View.ResourceViewModel
    
    public let mapper: Mapper
    private let resourceView: View
    private var loadingView: ResourceLoadingView?
    private var errorView: ResourceErrorView?
    
    public init(resourceView: View, loadingView: ResourceLoadingView?, errorView: ResourceErrorView?, mapper: @escaping Mapper) {
        self.resourceView = resourceView
        self.loadingView = loadingView
        self.errorView = errorView
        self.mapper = mapper
    }
    
    public init(resourceView: View, loadingView: ResourceLoadingView?, errorView: ResourceErrorView?) where Resource == View.ResourceViewModel {
        self.resourceView = resourceView
        self.loadingView = loadingView
        self.errorView = errorView
        self.mapper = { $0 }
    }
    
    public static var errorMessage: String {
        "Error message"
    }
    
    public func didStartLoading() {
        errorView?.display(.noError)
        loadingView?.display(.init(isLoading: true))
    }
    
    public func didFinishLoading(with resource: Resource) {
        do {
            resourceView.display(try mapper(resource))
            loadingView?.display(ResourceLoadingViewModel(isLoading: false))
        } catch {
            didFinishLoading(with: error)
        }
    }
    
    public func didFinishLoading(with error: Error) {
        errorView?.display(ResourceErrorViewModel.error(message: Self.errorMessage))
        loadingView?.display(ResourceLoadingViewModel(isLoading: false))
    }
}
