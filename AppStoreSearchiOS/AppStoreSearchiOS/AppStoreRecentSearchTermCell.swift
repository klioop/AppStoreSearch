//
//  AppStoreRecentSearchTermCell.swift
//  AppStoreSearchiOS
//
//  Created by Lee Sam on 2023/09/16.
//

import UIKit
import SnapKit

final class AppStoreRecentSearchTermCell: UITableViewCell {
    
    var term: String {
        get { termLabel.text ?? "" }
        set { termLabel.text = newValue }
    }
    
    private lazy var container: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 10
        indicatingImageView.snp.makeConstraints { $0.width.height.equalTo(16) }
        [indicatingImageView, termLabel].forEach(stack.addArrangedSubview)
        return stack
    }()
    
    private lazy var indicatingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "magnifyingglass")
        return imageView
    }()
    
    private lazy var termLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .link
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(container)
        container.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(8)
            $0.leading.equalToSuperview().offset(20)
        }
    }
    
    required init?(coder: NSCoder) { nil }
}
