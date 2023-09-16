//
//  AppStoreSearchContainerViewController.swift
//  AppStoreSearchiOS
//
//  Created by Lee Sam on 2023/09/16.
//

import UIKit
import SnapKit

final class AppStoreSearchContainerViewController: UIViewController {
    
    private var searchView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(searchView)
        searchView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(ScreenSafeArea.top)
            $0.horizontalEdges.equalToSuperview()
        }
    }
}
