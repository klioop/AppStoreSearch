//
//  AppsFoundViewAdapter.swift
//  AppStoreSearchApp
//
//  Created by Lee Sam on 2023/09/19.
//

import Foundation
import AppStoreSearch
import AppStoreSearchiOS

final class AppsFoundViewAdapter: ResourceView {
    
    private weak var controller: ListViewController?
    
    init(controller: ListViewController) {
        self.controller = controller
    }
    
    func display(_ viewModel: [App]) {
        let cellControllers = viewModel.map { app -> (App, AppStoreSearchResultCellController) in
            let int = Int(app.rating)
            let decimal = app.rating.truncatingRemainder(dividingBy: Double(int))
            return (
                app,
                AppStoreSearchResultCellController(
                    viewModel: AppStoreSearchResultViewModel(
                        title: app.title,
                        seller: app.seller,
                        ratings: (int, decimal),
                        numberOfRatingsText: "\(app.numberOfRatings)",
                        logoImage: app.logo
                    ),
                    galleryCellControllers: galleries(for: app.images)
                )
            )
        }
            .map(TableCellController.init)
        
        controller?.display(cellControllers)
    }
    
    // MARK: - Helpers
    
    private func galleries(for images: [URL]) -> [CellController] {
        let maxImageCount = 3
        let totalImageCount = images.count
        let endIndex = totalImageCount < maxImageCount ? totalImageCount : 3
        return images[..<endIndex]
            .map(AppGalleryCellController.init)
            .map(CellController.init)
    }
}
