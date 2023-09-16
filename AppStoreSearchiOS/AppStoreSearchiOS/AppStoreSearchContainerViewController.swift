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
    
    public convenience init(searchView: UIView) {
        self.init()
        self.searchView = searchView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(searchView)
        searchView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(ScreenSafeArea.top)
            $0.horizontalEdges.equalToSuperview()
        }
    }
}
