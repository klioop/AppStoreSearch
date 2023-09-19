//
//  AppGalleryCell.swift
//  AppStoreSearchiOS
//
//  Created by Lee Sam on 2023/09/17.
//

import UIKit
import SnapKit

public final class AppGalleryCell: UICollectionViewCell {
    
    private(set) lazy var imageContainer: ShimmeringView = {
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
        
        contentView.addSubview(imageContainer)
        imageContainer.snp.makeConstraints { $0.edges.equalToSuperview() }
        imageContainer.layer.cornerRadius = 16
        imageContainer.layer.cornerCurve = .continuous
        imageContainer.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) { nil }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = .none
    }
}
