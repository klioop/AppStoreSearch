//
//  AppPreviewCell.swift
//  AppStoreSearchiOS
//
//  Created by Lee Sam on 2023/09/17.
//

import UIKit
import SnapKit

final class AppPreviewCell: UITableViewCell {
    
    var title: String {
        get { label.text ?? "" }
        set { label.text = newValue }
    }
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    var gallery: UIView! {
        didSet { layout() }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) { nil }
    
    // MARK: - Helpers
    
    private func layout() {
        [label, gallery].forEach(contentView.addSubview)
        label.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        gallery.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).offset(16)
            $0.bottom.horizontalEdges.equalToSuperview()
            $0.height.equalTo(UIScreen.main.bounds.height * 0.6)
        }
    }
}
