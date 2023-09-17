//
//  AppTitleCell.swift
//  AppStoreSearchiOS
//
//  Created by Lee Sam on 2023/09/17.
//

import UIKit
import SnapKit

final class AppTitleCell: UITableViewCell {
    
    var title: String {
        get { titleLabel.text ?? "" }
        set { titleLabel.text = newValue }
    }
    
    var descriptionText: String {
        get { descriptionLabel.text ?? "" }
        set { descriptionLabel.text = newValue }
    }
    
    private(set) lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGray4
        return imageView
    }()
    
    private lazy var container: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 3
        [titleLabel, descriptionLabel].forEach(stack.addArrangedSubview)
        return stack
    }()
    
    private lazy var titleLabel = label(
        font: .systemFont(ofSize: 24, weight: .medium),
        color: .label
    )
    private lazy var descriptionLabel = label(
        font: .systemFont(ofSize: 16, weight: .regular),
        color: .secondaryLabel
    )
    private lazy var buttonContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .link
        view.addSubview(button)
        button.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        return view
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        let attributed = NSAttributedString(
            string: "받기",
            attributes: [
                .font: UIFont.systemFont(ofSize: 16, weight: .bold),
                .foregroundColor: UIColor.white
            ]
        )
        button.setAttributedTitle(attributed, for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        [logoImageView, container, buttonContainer].forEach(contentView.addSubview)
        logoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.width.height.equalTo(120)
        }
        container.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.top)
            $0.leading.equalTo(logoImageView.snp.trailing).offset(12)
        }
        buttonContainer.snp.makeConstraints {
            $0.bottom.equalTo(logoImageView.snp.bottom)
            $0.leading.equalTo(logoImageView.snp.trailing).offset(12)
            $0.height.equalTo(30)
        }
        logoImageView.layer.cornerRadius = 16
        logoImageView.layer.cornerCurve = .continuous
        buttonContainer.layer.cornerRadius = 30 * 0.5
        buttonContainer.layer.cornerCurve = .continuous
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
