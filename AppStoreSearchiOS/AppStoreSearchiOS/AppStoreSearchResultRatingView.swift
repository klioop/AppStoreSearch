//
//  AppStoreSearchResultRatingView.swift
//  AppStoreSearchiOS
//
//  Created by Lee Sam on 2023/09/16.
//

import UIKit
import SnapKit

final class AppStoreSearchResultRatingView: UIView {
    
    var numberOfRatings: String {
        get { countLabel.text ?? "" }
        set { countLabel.text = newValue }
    }
    
    var ratings: (int: Int, decimal: CGFloat) = (5, 0.0) {
        didSet { update(ratings) }
    }
    
    private lazy var container: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 3
        (maskingViews + [countLabel]).forEach(stack.addArrangedSubview)
        return stack
    }()
    
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .tertiaryLabel
        return label
    }()
    
    private lazy var maskingViews = (0..<5).map { _ in maskingView() }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(container)
        container.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    required init?(coder: NSCoder) { nil }
    
    // MARK: - Helpers
    
    private func update(_ ratings: (int: Int, decimal: CGFloat)) {
        (0..<ratings.int).forEach { index in
            maskingViews[index].progress = 1.0
        }
        maskingViews[ratings.int].progress = ratings.decimal
        maskingViews[(ratings.int + 1)...].forEach { $0.isHidden = true }
    }
    
    private func maskingView() -> AppStoreSearchRatingMaskingView {
        let view = AppStoreSearchRatingMaskingView()
        view.snp.makeConstraints { $0.width.height.equalTo(12) }
        return view
    }
}
