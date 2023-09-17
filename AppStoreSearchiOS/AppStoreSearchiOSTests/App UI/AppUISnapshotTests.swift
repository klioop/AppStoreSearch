//
//  AppUISnapshotTests.swift
//  AppStoreSearchiOSTests
//
//  Created by Lee Sam on 2023/09/17.
//

import XCTest
import AppStoreSearchiOS

final class AppUISnapshotTests: XCTestCase {
    
    func test_appUI() {
        let (sut, list) = makeSUT()
        let title = AppTitleCellController(
            viewModel: AppTitleViewModel(
                title: "a title",
                description: "a description",
                logoImage: anyURL()
            )
        )
        let description = AppDescriptionCellController(
            viewModel: AppDescriptionViewModel(
                ratingText: "3.4",
                numberOfRatingText: "1.1만개의 평가",
                rating: (3, 0.43),
                rankingText: "#4",
                rankDescription: "rank",
                ageText: "4+",
                ageDescription: "age"
            )
        )
        let feature = AppNewFeatureCellController(
            viewModel: AppNewFeatureViewModel(
                title: "a title",
                version: "version x.xx.x",
                firstDescription: "- a description\n- a description a description a description a description a description a description",
                secondDescription: "a description"
            )
        )
        let galleryCell0 = AppGalleryCellController(viewModel: anyURL())
        let galleryCell1 = AppGalleryCellController(viewModel: anyURL())
        let gallery = [galleryCell0, galleryCell1].map(CellController.init)
        let preview = AppPreviewCellController(galleryCellControllers: gallery)
        let cellControllers = [title, description, feature, preview].map(TableCellController.init)
        
        list.display(cellControllers)
        sut.loadViewIfNeeded()
        
        record(sut.snapshot(for: .iPhone11(style: .light)), named: "APP_light")
    }
    
    // MARK: - Helpers
    
    private func makeSUT() -> (sut: AppContainerViewController, list: ListViewController) {
        let headerViewController = AppHeaderViewController {}
        let list = ListViewController()
        let sut = AppContainerViewController(
            header: headerViewController.view(),
            listViewController: list
        )
        return (sut, list)
    }
}

func anyURL() -> URL {
    URL(string: "http://any-url.com")!
}
