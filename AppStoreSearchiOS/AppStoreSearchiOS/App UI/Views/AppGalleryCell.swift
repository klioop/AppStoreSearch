//
//  AppGalleryCell.swift
//  AppStoreSearchiOS
//
//  Created by Lee Sam on 2023/09/17.
//

import UIKit
import SnapKit

final class AppGalleryCell: UICollectionViewCell {
    
    private(set) lazy var container: ShimmeringView = {
        let view = ShimmeringView()
        view.addSubview(imageView)
        view.backgroundColor = .systemGray4
        imageView.snp.makeConstraints { $0.edges.equalToSuperview() }
        return view
    }()
    
    private(set) lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(container)
        container.snp.makeConstraints { $0.edges.equalToSuperview() }
        container.layer.cornerRadius = 16
        container.layer.cornerCurve = .continuous
    }
    
    required init?(coder: NSCoder) { nil }
}
