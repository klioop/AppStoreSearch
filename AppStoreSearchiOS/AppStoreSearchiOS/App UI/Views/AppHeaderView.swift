//
//  AppHeaderView.swift
//  AppStoreSearchiOS
//
//  Created by Lee Sam on 2023/09/17.
//

import UIKit
import SnapKit

public final class AppHeaderView: UIView {
    
    private lazy var container: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 5
        stack.alignment = .center
        backImageView.snp.makeConstraints {
            $0.width.equalTo(18)
            $0.height.equalTo(24)
        }
        [backImageView, label].forEach(stack.addArrangedSubview)
        return stack
    }()
    
    private lazy var backImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(systemName: "chevron.left")
        imageView.image = image
        imageView.tintColor = .systemGray2
        return imageView
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 16)
        label.text = "검색"
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTap), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemGray6
        [container, button].forEach(addSubview)
        container.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().inset(16)
        }
        button.snp.makeConstraints { $0.edges.equalTo(container.snp.edges) }
    }
    
    required init?(coder: NSCoder) { nil }
    
    var onTap: (() -> Void)?
    
    // MARK: - Helpers
    
    @objc private func didTap() {
        onTap?()
    }
}
