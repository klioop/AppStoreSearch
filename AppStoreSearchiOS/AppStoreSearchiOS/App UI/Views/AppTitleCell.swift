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
    
    private(set) lazy var logoContainer: ShimmeringView = {
        let view = ShimmeringView()
        view.addSubview(logoImageView)
        view.backgroundColor = .systemGray4
        logoImageView.snp.makeConstraints { $0.edges.equalToSuperview() }
        return view
    }()
    
    private(set) lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
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
        font: .systemFont(ofSize: 24, weight: .bold),
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
        
        [logoContainer, container, buttonContainer].forEach(contentView.addSubview)
        logoContainer.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.width.height.equalTo(120)
        }
        container.snp.makeConstraints {
            $0.top.equalTo(logoContainer.snp.top)
            $0.leading.equalTo(logoContainer.snp.trailing).offset(12)
        }
        buttonContainer.snp.makeConstraints {
            $0.bottom.equalTo(logoContainer.snp.bottom)
            $0.leading.equalTo(logoContainer.snp.trailing).offset(12)
            $0.height.equalTo(30)
        }
        logoContainer.layer.cornerRadius = 16
        logoContainer.layer.cornerCurve = .continuous
        logoContainer.layer.masksToBounds = true
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
