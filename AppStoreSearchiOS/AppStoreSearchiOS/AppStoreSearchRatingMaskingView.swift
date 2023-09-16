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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) { nil }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addSubview(progressView)
        let offset = frame.size.width * progress
        progressView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.leading.equalToSuperview().offset(offset)
        }
        maskLayer.contents = UIImage(systemName: "star")?.cgImage
        layer.mask = maskLayer
    }
}
