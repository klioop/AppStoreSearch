//
//  AppUIComposer.swift
//  AppStoreSearchApp
//
//  Created by Lee Sam on 2023/09/20.
//

import UIKit
import Combine
import AppStoreSearch
import AppStoreSearchiOS

public final class AppUIComposer {
    private typealias LogoImageDataLoadPresentationAdapter = LoadResourcePresentationAdapter<URL, Data, WeakRefVirtualProxy<AppTitleCellController>>
    private typealias AppImageDataLoadPresentationAdapter = LoadResourcePresentationAdapter<URL, Data, WeakRefVirtualProxy<AppGalleryCellController>>
    
    private init() {}
    
    public static func composedWith(
        app: App,
        imageDataLoader: @escaping (URL) -> AnyPublisher<Data, Error>,
        callback: @escaping () -> Void
    ) -> AppContainerViewController {
        let logoImagePresentationAdapter = LogoImageDataLoadPresentationAdapter(loader: imageDataLoader)
        let headerViewController = AppHeaderViewController(callback: callback)
        let list = ListViewController()
        let container = AppContainerViewController(
            header: headerViewController.view(),
            listViewController: list
        )
        let title = AppTitleCellController(
            viewModel: AppTitleViewModel(
                title: app.title,
                seller: app.seller
            ),
            requestLogoImage: { logoImagePresentationAdapter.loadResource(with: app.logo) }
        )
        let description = AppDescriptionCellController(
            viewModel: AppStoreAppPresenter.mapToDescription(app)
        )
        let newFeature = AppNewFeatureCellController(
            viewModel: AppNewFeaturePresenter.map(app)
        )
        let galleries = app.images.map { image in
            let presentationAdapter = AppImageDataLoadPresentationAdapter(loader: imageDataLoader)
            let cell = AppGalleryCellController(
                requestImage: { presentationAdapter.loadResource(with: image) },
                cancelRequestImage: presentationAdapter.cancel
            )
            presentationAdapter.presenter = LoadResourcePresenter(
                resourceView: WeakRefVirtualProxy(cell),
                loadingView: WeakRefVirtualProxy(cell),
                errorView: .none,
                mapper: UIImage.tryMake
            )
            return cell
        }
            .map(CellController.init)
        let preview = AppPreviewCellController(galleryCellControllers: galleries)
        let cellControllers = [title, description, newFeature, preview].map(TableCellController.init)
        logoImagePresentationAdapter.presenter = LoadResourcePresenter(
            resourceView: WeakRefVirtualProxy(title),
            loadingView: WeakRefVirtualProxy(title),
            errorView: .none,
            mapper: UIImage.tryMake
        )
        list.configure = { tableView in
            tableView.allowsSelection = false
            tableView.backgroundColor = .systemGray6
        }
        list.display(cellControllers)
        return container
    }
}
