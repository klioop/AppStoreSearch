//
//  AppStoreRecentSearchTitleCell.swift
//  AppStoreSearchiOS
//
//  Created by Lee Sam on 2023/09/16.
//

import UIKit
import SnapKit

final class AppStoreRecentSearchTitleCell: UITableViewCell {
    
    var title: String {
        get { label.text ?? "" }
        set { label.text = newValue }
    }
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(label)
        label.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
    }
    
    required init?(coder: NSCoder) { nil }
}
