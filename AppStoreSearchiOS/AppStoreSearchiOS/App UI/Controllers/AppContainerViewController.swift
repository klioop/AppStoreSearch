//
//  AppContainerViewController.swift
//  AppStoreSearchiOS
//
//  Created by Lee Sam on 2023/09/17.
//

import UIKit
import SnapKit

public final class AppContainerViewController: UIViewController {
    
    private var header: AppHeaderView!
    private var listViewController: ListViewController!
    
    public convenience init(header: AppHeaderView, listViewController: ListViewController) {
        self.init()
        self.header = header
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
        [header, listView].forEach(view.addSubview)
        header.snp.makeConstraints {
            $0.top.equalToSuperview().offset(ScreenSafeArea.top)
            $0.horizontalEdges.equalToSuperview()
        }
        listView.snp.makeConstraints {
            $0.top.equalTo(header.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        listViewController.didMove(toParent: self)
    }
}
