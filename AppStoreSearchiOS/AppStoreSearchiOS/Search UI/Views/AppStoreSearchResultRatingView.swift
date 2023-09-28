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
    
    var ratings: (int: Int, decimal: CGFloat) {
        get { getRating() }
        set { update(newValue) }
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
    
    func reset() {
        maskingViews.forEach { $0.reset() }
    }
    
    private func update(_ ratings: (int: Int, decimal: CGFloat)) {
        reset()
        
        (0..<ratings.int).forEach { index in
            maskingViews[index].progress = 1.0
        }
        
        guard isNotMax(ratings.int) else { return }
        
        maskingViews[ratings.int].progress = ratings.decimal
        maskingViews[(ratings.int + 1)...].forEach { $0.isHidden = true }
    }
    
    private func getRating() -> (int: Int, decimal: CGFloat) {
        let intPart = Int(
            maskingViews
                .map(\.progress)
                .filter { $0 == 1 }
                .reduce(0, +)
        )
        guard isNotMax(intPart) else { return (intPart, 0) }
        
        return (intPart, maskingViews[intPart].progress)
    }
    
    private func isNotMax(_ rating: Int) -> Bool {
        !(rating == 5)
    }
    
    private func maskingView() -> AppStoreSearchRatingMaskingView {
        let view = AppStoreSearchRatingMaskingView()
        view.snp.makeConstraints { $0.width.height.equalTo(12) }
        return view
    }
}
