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
    
    var rankingTitle: String {
        get { genreView.title }
        set { genreView.title = newValue }
    }
    
    var rankingDescription: String {
        get { genreView.descriptionText }
        set { genreView.descriptionText = newValue }
    }
    
    var ageTitle: String {
        get { ageView.title }
        set { ageView.title = newValue }
    }
    
    var ageDescription: String {
        get { ageView.descriptionText }
        set { ageView.descriptionText = newValue }
    }
    
    private lazy var ratingView = AppDescriptionRatingView()
    private lazy var genreView = AppDescriptionGeneralInfoView()
    private lazy var ageView = AppDescriptionGeneralInfoView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        [ratingView, genreView, ageView].forEach(contentView.addSubview)
        ratingView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().offset(20)
        }
        genreView.snp.makeConstraints {
            $0.centerX.equalToSuperview().offset(50)
            $0.centerY.equalTo(ratingView.snp.centerY)
        }
        ageView.snp.makeConstraints {
            $0.centerY.equalTo(ratingView.snp.centerY)
            $0.trailing.equalToSuperview().inset(20)
        }
    }
    
    required init?(coder: NSCoder) { nil }
}
