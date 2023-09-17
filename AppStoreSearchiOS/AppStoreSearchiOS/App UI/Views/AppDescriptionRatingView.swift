//
//  AppDescriptionRatingView.swift
//  AppStoreSearchiOS
//
//  Created by Lee Sam on 2023/09/17.
//

import UIKit
import SnapKit

final class AppDescriptionRatingView: UIView {
    
    var ratingText: String {
        get { ratingLabel.text ?? "" }
        set { ratingLabel.text = newValue }
    }
    
    var numberOfRatingText: String {
        get { numberOfRatingLabel.text ?? "" }
        set { numberOfRatingLabel.text = newValue }
    }
    
    var rating: (int: Int, decimal: CGFloat) = (5, 0.0) {
        didSet { update(rating) }
    }
    
    private lazy var topContainer: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 3
        [ratingContainer, numberOfRatingLabel].forEach(stack.addArrangedSubview)
        return stack
    }()
    
    private lazy var ratingContainer: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 2
        ([ratingLabel] + maskingViews).forEach(stack.addArrangedSubview)
        return stack
    }()
    
    private lazy var ratingLabel = label(
        font: .systemFont(ofSize: 20, weight: .bold),
        color: .systemGray
    )
    private lazy var numberOfRatingLabel = label(
        font: .systemFont(ofSize: 12, weight: .regular),
        color: .tertiaryLabel
    )
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(topContainer)
        topContainer.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    required init?(coder: NSCoder) { nil }
    
    private lazy var maskingViews = (0..<5).map { _ in maskingView() }
    
    // MARK: - Helpers
    
    private func update(_ rating: (int: Int, decimal: CGFloat)) {
        (0..<rating.int).forEach { index in
            maskingViews[index].progress = 1.0
        }
        maskingViews[rating.int].progress = rating.decimal
        maskingViews[(rating.int + 1)...].forEach { $0.isHidden = true }
    }
    
    private func maskingView() -> AppStoreSearchRatingMaskingView {
        let view = AppStoreSearchRatingMaskingView()
        view.snp.makeConstraints { $0.width.height.equalTo(16) }
        return view
    }
    
    private func label(font: UIFont, color: UIColor) -> UILabel {
        let label = UILabel()
        label.font = font
        label.textColor = color
        return label
    }
}
