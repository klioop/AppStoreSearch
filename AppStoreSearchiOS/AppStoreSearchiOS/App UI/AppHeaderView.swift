//
//  AppHeaderView.swift
//  AppStoreSearchiOS
//
//  Created by Lee Sam on 2023/09/17.
//

import UIKit
import SnapKit

public final class AppHeaderView: UIView {
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "chevron.left")
        button.setImage(image, for: .normal)
        button.tintColor = .systemGray2
        button.addTarget(self, action: #selector(didTap), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(button)
        button.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.width.height.equalTo(24)
        }
    }
    
    required init?(coder: NSCoder) { nil }
    
    var onTap: (() -> Void)?
    
    // MARK: - Helpers
    
    @objc private func didTap() {
        onTap?()
    }
}
