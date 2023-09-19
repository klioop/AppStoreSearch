//
//  LoadResourcePresentationAdapter.swift
//  AppStoreSearchApp
//
//  Created by Lee Sam on 2023/09/18.
//

import Combine
import AppStoreSearch

final class LoadResourcePresentationAdapter<RequiredInfo, Resource, View: ResourceView> {
    private var cancellable: Cancellable?
    private var isLoading = false
    
    private let loader: (RequiredInfo) -> AnyPublisher<Resource, Error>

    init(loader: @escaping (RequiredInfo) -> AnyPublisher<Resource, Error>) {
        self.loader = loader
    }
    
    var presenter: LoadResourcePresenter<Resource, View>?
    
    func loadResource(with info: RequiredInfo) {
        guard !isLoading else { return }
        
        presenter?.didStartLoading()
        isLoading = true
        
        cancellable = loader(info)
            .dispatchOnMainQueue()
            .handleEvents(
                receiveCancel: { [weak self] in
                    self?.isLoading = false
                }
            )
            .sink(
                receiveCompletion: { [weak self] completion in
                    guard let self else { return }
                    
                    switch completion {
                    case .finished: break
                        
                    case let .failure(error):
                        presenter?.didFinishLoading(with: error)
                    }
                    
                    isLoading = false
                }, receiveValue: { [weak presenter] resource in
                    presenter?.didFinishLoading(with: resource)
                }
            )
    }
}
