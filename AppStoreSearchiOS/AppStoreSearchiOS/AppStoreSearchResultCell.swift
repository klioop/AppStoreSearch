//
//  AppStoreSearchResultCell.swift
//  AppStoreSearchiOS
//
//  Created by Lee Sam on 2023/09/16.
//

import UIKit
import SnapKit

final class AppStoreSearchResultCell: UITableViewCell {
    
    private(set) lazy var logoImageView = UIImageView()
    
    private lazy var titleLabel = label(
        font: .systemFont(ofSize: 14, weight: .medium),
        color: .label
    )
    private lazy var descriptionLabel = label(
        font: .systemFont(ofSize: 11, weight: .regular),
        color: .secondaryLabel
    )
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) { nil }
    
    // MARK: - Helpers
    
    private func label(font: UIFont, color: UIColor) -> UILabel {
        let label = UILabel()
        label.font = font
        label.textColor = color
        return label
    }
}
