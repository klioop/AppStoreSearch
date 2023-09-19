//
//  AppDescriptionGeneralInfoView.swift
//  AppStoreSearchiOS
//
//  Created by Lee Sam on 2023/09/17.
//

import UIKit
import SnapKit

final class AppDescriptionGeneralInfoView: UIView {
    
    var title: String {
        get { titleLabel.text ?? "" }
        set { titleLabel.text = newValue }
    }
    
    var descriptionText: String {
        get { descriptionLabel.text ?? "" }
        set { descriptionLabel.text = newValue }
    }
    
    private lazy var container: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 3
        [titleLabel, descriptionLabel].forEach(stack.addArrangedSubview)
        return stack
    }()
    
    private lazy var titleLabel = label(
        font: .systemFont(ofSize: 20, weight: .bold),
        color: .systemGray
    )
    private lazy var descriptionLabel = label(
        font: .systemFont(ofSize: 12, weight: .regular),
        color: .tertiaryLabel
    )
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(container)
        container.snp.makeConstraints { $0.edges.equalToSuperview() }
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
