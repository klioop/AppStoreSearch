//
//  AppStoreSearchResultCell.swift
//  AppStoreSearchiOS
//
//  Created by Lee Sam on 2023/09/16.
//

import UIKit
import SnapKit

public final class AppStoreSearchResultCell: UITableViewCell {
    
    var title: String {
        get { titleLabel.text ?? "" }
        set { titleLabel.text = newValue }
    }
    
    var seller: String {
        get { sellerLabel.text ?? "" }
        set { sellerLabel.text = newValue }
    }
    
    var ratings: (int: Int, decimal: CGFloat) {
        get { ratingView.ratings }
        set { ratingView.ratings = newValue }
    }
    
    var numberOfRatings: String {
        get { ratingView.numberOfRatings }
        set { update(newValue) }
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
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var container: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 6
        [titleLabel, sellerLabel, ratingView].forEach(stack.addArrangedSubview)
        return stack
    }()
    
    private lazy var titleLabel = label(
        font: .systemFont(ofSize: 14, weight: .medium),
        color: .label
    )
    private lazy var sellerLabel = label(
        font: .systemFont(ofSize: 14, weight: .regular),
        color: .secondaryLabel
    )
    private lazy var ratingView = AppStoreSearchResultRatingView()
    
    private lazy var buttonContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.addSubview(button)
        button.snp.makeConstraints { $0.center.equalToSuperview() }
        return view
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        let attributed = NSAttributedString(
            string: "받기",
            attributes: [
                .font: UIFont.systemFont(ofSize: 14, weight: .bold)
            ]
        )
        button.setAttributedTitle(attributed, for: .normal)
        return button
    }()
    
    private lazy var galleryContainerButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTapGallery), for: .touchUpInside)
        return button
    }()
    
    public var gallery: UICollectionView! {
        didSet { layout() }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) { nil }
    
    var onTapGallery: (() -> Void)?
    
    // MARK: - Helpers
    
    private func update(_ numberOfRatings: String) {
        ratingView.isHidden = numberOfRatings.isEmpty
        ratingView.numberOfRatings = numberOfRatings
    }
    
    private func layout() {
        [logoContainer, container, buttonContainer, gallery, galleryContainerButton].forEach(contentView.addSubview)
        logoContainer.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.width.height.equalTo(64)
        }
        container.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.top)
            $0.leading.equalTo(logoContainer.snp.trailing).offset(10)
            $0.trailing.equalTo(buttonContainer.snp.leading).inset(-10)
        }
        buttonContainer.snp.makeConstraints {
            $0.centerY.equalTo(logoContainer.snp.centerY)
            $0.trailing.equalToSuperview().inset(20)
            $0.width.equalTo(50)
            $0.height.equalTo(30)
        }
        gallery.snp.makeConstraints {
            $0.top.equalTo(logoContainer.snp.bottom).offset(30)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(20).priority(999)
            $0.height.equalTo(180)
        }
        galleryContainerButton.snp.makeConstraints { $0.edges.equalTo(gallery.snp.edges) }
        
        logoContainer.layer.cornerRadius = 8
        logoContainer.layer.cornerCurve = .continuous
        logoContainer.layer.masksToBounds = true
        logoContainer.layer.borderColor = UIColor.systemGray6.cgColor
        logoContainer.layer.borderWidth = 2
        buttonContainer.layer.cornerRadius = 30 / 2
        buttonContainer.layer.cornerCurve = .continuous
    }
    
    private func label(font: UIFont, color: UIColor) -> UILabel {
        let label = UILabel()
        label.font = font
        label.textColor = color
        return label
    }
    
    @objc private func didTapGallery() {
        onTapGallery?()
    }
}
