//
//  AppStoreSearchRatingMaskingView.swift
//  AppStoreSearchiOS
//
//  Created by Lee Sam on 2023/09/16.
//

import UIKit
import SnapKit

final class AppStoreSearchRatingMaskingView: UIView {
    var progress: CGFloat = 1.0
    
    private lazy var progressView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    private let maskLayer = CALayer()
    
    private var constraint: Constraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(progressView)
    }
    
    required init?(coder: NSCoder) { nil }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        progressView.frame = bounds
        progressView.frame.size.width = bounds.width * progress
        maskLayer.contents = UIImage(systemName: "star.fill")?.cgImage
        maskLayer.frame = bounds
        layer.mask = maskLayer
    }
}

