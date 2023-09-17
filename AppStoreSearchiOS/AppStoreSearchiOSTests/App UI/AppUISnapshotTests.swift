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
        let cellControllers = [title, description].map(TableCellController.init)
        
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
        list.configure = { tableView in
            tableView.separatorStyle = .none
        }
        return (sut, list)
    }
}

func anyURL() -> URL {
    URL(string: "http://any-url.com")!
}
