//
//  AppNewFeatureCell.swift
//  AppStoreSearchiOS
//
//  Created by Lee Sam on 2023/09/17.
//

import UIKit
import SnapKit

final class AppNewFeatureCell: UITableViewCell {
    
    var title: String {
        get { titleLabel.text ?? "" }
        set { titleLabel.text = newValue }
    }
    
    var version: String {
        get { versionLabel.text ?? "" }
        set { versionLabel.text = newValue }
    }
    
    var releaseDateTitle: String {
        get { releaseDateTitleLabel.text ?? "" }
        set { releaseDateTitleLabel.text = newValue }
    }
    
    var currentReleaseDate: String {
        get { currentReleaseDateLabel.text ?? "" }
        set { currentReleaseDateLabel.text = newValue }
    }
    
    var firstDescription: String {
        get { descriptionLabel0.text ?? "" }
        set { descriptionLabel0.text = newValue }
    }
    
    var secondDescription: String {
        get { descriptionLabel1.text ?? "" }
        set {
            button.isHidden = newValue.isEmpty
            descriptionLabel1.text = newValue
        }
    }
    
    private lazy var titleContainer: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 3
        [titleLabel, versionLabel].forEach(stack.addArrangedSubview)
        return stack
    }()
    
    private lazy var releaseContainer: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .trailing
        stack.spacing = 5
        [releaseDateTitleLabel, currentReleaseDateLabel].forEach(stack.addArrangedSubview)
        return stack
    }()
    
    private lazy var titleLabel = label(
        font: .systemFont(ofSize: 18, weight: .bold),
        color: .label
    )
    private lazy var versionLabel = label(
        font: .systemFont(ofSize: 14, weight: .regular),
        color: .secondaryLabel
    )
    private lazy var releaseDateTitleLabel = label(
        font: .systemFont(ofSize: 14, weight: .medium),
        color: .label
    )
    private lazy var currentReleaseDateLabel = label(
        font: .systemFont(ofSize: 14, weight: .regular),
        color: .secondaryLabel
    )
    private lazy var descriptionContainer: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 1
        [descriptionLabel0, descriptionLabel1].forEach(stack.addArrangedSubview)
        return stack
    }()
    
    private lazy var descriptionLabel0 = label(
        font: .systemFont(ofSize: 14, weight: .regular),
        color: .label,
        lines: 0
    )
    private lazy var descriptionLabel1 = label(
        font: .systemFont(ofSize: 14, weight: .regular),
        color: .label,
        lines: 0
    )
    
    private lazy var buttonContainer: UIStackView = {
        let stack = UIStackView()
        button.snp.makeConstraints { $0.height.equalTo(24) }
        stack.addArrangedSubview(button)
        return stack
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("더 보기", for: .normal)
        button.addTarget(self, action: #selector(didTap), for: .touchUpInside)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        [titleContainer, descriptionContainer, buttonContainer, releaseContainer].forEach(contentView.addSubview)
        titleContainer.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(20)
        }
        descriptionContainer.snp.makeConstraints {
            $0.top.equalTo(titleContainer.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        buttonContainer.snp.makeConstraints {
            $0.top.equalTo(descriptionContainer.snp.bottom)
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(26)
        }
        releaseContainer.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        descriptionLabel1.isHidden = true
    }
    
    required init?(coder: NSCoder) { nil }
    
    var onTap: (() -> Void)?
    
    // MARK: - Helpers
    
    private func label(font: UIFont, color: UIColor, lines: Int = 1) -> UILabel {
        let label = UILabel()
        label.font = font
        label.textColor = color
        label.numberOfLines = lines
        return label
    }
    
    @objc private func didTap() {
        self.descriptionLabel1.isHidden = false
        self.button.isHidden = true
        onTap?()
    }
}
