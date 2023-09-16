//
//  AppStoreSearchContainerViewController.swift
//  AppStoreSearchiOS
//
//  Created by Lee Sam on 2023/09/16.
//

import UIKit
import SnapKit

public final class AppStoreSearchContainerViewController: UIViewController {
    
    private var searchView: UIView!
    private var listViewController: UIViewController!
    
    public convenience init(searchView: UIView, listViewController: UIViewController) {
        self.init()
        self.searchView = searchView
        self.listViewController = listViewController
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        layout()
    }
    
    // MARK: - Helpers
    
    private func layout() {
        addChild(listViewController)
        
        let listView = listViewController.view!
        [searchView, listView].forEach(view.addSubview)
        searchView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(ScreenSafeArea.top + 20)
            $0.horizontalEdges.equalToSuperview()
        }
        listView.snp.makeConstraints {
            $0.top.equalTo(searchView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        listViewController.didMove(toParent: self)
    }
}
