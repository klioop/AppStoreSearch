//
//  AppStoreSearchResultCell.swift
//  AppStoreSearchiOS
//
//  Created by Lee Sam on 2023/09/16.
//

import UIKit
import SnapKit

final class AppStoreSearchResultCell: UITableViewCell {
    
    var title: String {
        get { titleLabel.text ?? "" }
        set { titleLabel.text = newValue }
    }
    
    var descriptionText: String {
        get { descriptionLabel.text ?? "" }
        set { descriptionLabel.text = newValue }
    }
    
    var ratings: (int: Int, decimal: CGFloat) {
        get { ratingsView.ratings }
        set { ratingsView.ratings = newValue }
    }
    
    var numberOfRatings: String {
        get { ratingsView.numberOfRatings }
        set { ratingsView.numberOfRatings = newValue }
    }
    
    private(set) lazy var logoImageView = UIImageView()
    
    private lazy var container: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 6
        [titleLabel, descriptionLabel, ratingsView].forEach(stack.addArrangedSubview)
        return stack
    }()
    
    private lazy var titleLabel = label(
        font: .systemFont(ofSize: 14, weight: .medium),
        color: .label
    )
    private lazy var descriptionLabel = label(
        font: .systemFont(ofSize: 11, weight: .regular),
        color: .secondaryLabel
    )
    private lazy var ratingsView = AppStoreSearchResultRatingView()
    
    private lazy var buttonContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.addSubview(button)
        button.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        return view
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("받기", for: .normal)
        return button
    }()
    
    private lazy var imageViews = (0..<3).map { _ in UIImageView() }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        [logoImageView, container, buttonContainer].forEach(contentView.addSubview)
        logoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.width.height.equalTo(56)
        }
        container.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.top)
            $0.leading.equalTo(logoImageView.snp.trailing).offset(10)
        }
        buttonContainer.snp.makeConstraints {
            $0.centerY.equalTo(logoImageView.snp.centerY)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(36)
        }
        logoImageView.layer.cornerRadius = 8
        logoImageView.layer.cornerCurve = .continuous
        buttonContainer.layer.cornerRadius = 36 / 2
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
