//
//  AppDescriptionCell.swift
//  AppStoreSearchiOS
//
//  Created by Lee Sam on 2023/09/17.
//

import UIKit
import SnapKit

final class AppDescriptionCell: UITableViewCell {
    
    var ratingText: String {
        get { ratingView.ratingText }
        set { ratingView.ratingText = newValue }
    }
    
    var numberOfRatingText: String {
        get { ratingView.numberOfRatingText }
        set { ratingView.numberOfRatingText = newValue }
    }
    
    var rating: (int: Int, decimal: CGFloat) {
        get { ratingView.rating }
        set { ratingView.rating = newValue }
    }
    
    private lazy var ratingView = AppDescriptionRatingView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(ratingView)
        ratingView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.leading.equalToSuperview().offset(16)
        }
    }
    
    required init?(coder: NSCoder) { nil }
}
