//
//  AppsFoundViewAdapter.swift
//  AppStoreSearchApp
//
//  Created by Lee Sam on 2023/09/19.
//

import UIKit
import Combine
import AppStoreSearch
import AppStoreSearchiOS

final class AppsFoundViewAdapter: ResourceView {
    private typealias LogoImageDataLoadPresentationAdapter = LoadResourcePresentationAdapter<URL, Data, WeakRefVirtualProxy<AppStoreSearchResultCellController>>
    private typealias AppImageDataLoadPresentationAdapter = LoadResourcePresentationAdapter<URL, Data, WeakRefVirtualProxy<AppGalleryCellController>>
    
    private weak var controller: ListViewController?
    private let imageDataLoader: (URL) -> AnyPublisher<Data, Error>
    
    init(controller: ListViewController, imageDataLoader: @escaping (URL) -> AnyPublisher<Data, Error>) {
        self.controller = controller
        self.imageDataLoader = imageDataLoader
    }
    
    func display(_ viewModel: [App]) {
        let cellControllers = viewModel.map { app -> (App, AppStoreSearchResultCellController) in
            let imageDataPresentationAdapter = LogoImageDataLoadPresentationAdapter(loader: imageDataLoader)
            let cell = AppStoreSearchResultCellController(
                viewModel: AppStoreSearchFoundAppPresenter.map(app),
                galleryCellControllers: galleries(for: app.images),
                requestLogoImage: { imageDataPresentationAdapter.loadResource(with: app.logo) },
                cancelRequestLogoImage: imageDataPresentationAdapter.cancel
            )
            imageDataPresentationAdapter.presenter = LoadResourcePresenter(
                resourceView: WeakRefVirtualProxy(cell),
                loadingView: WeakRefVirtualProxy(cell),
                errorView: .none,
                mapper: UIImage.tryMake
            )
            return (app, cell)
        }
            .map(TableCellController.init)
        
        controller?.display(cellControllers)
    }
    
    // MARK: - Helpers
    
    private func galleries(for images: [URL]) -> [CellController] {
        let maxImageCount = 3
        let totalImageCount = images.count
        let endIndex = totalImageCount < maxImageCount ? totalImageCount : maxImageCount
        return images[..<endIndex]
            .map { image in
                let imageDataPresentationAdapter = AppImageDataLoadPresentationAdapter(loader: imageDataLoader)
                let cell = AppGalleryCellController(
                    requestImage: { imageDataPresentationAdapter.loadResource(with: image) },
                    cancelRequestImage: imageDataPresentationAdapter.cancel
                )
                imageDataPresentationAdapter.presenter = LoadResourcePresenter(
                    resourceView: WeakRefVirtualProxy(cell),
                    loadingView: WeakRefVirtualProxy(cell),
                    errorView: .none,
                    mapper: UIImage.tryMake
                )
                return cell
            }
            .map(CellController.init)
    }
}
