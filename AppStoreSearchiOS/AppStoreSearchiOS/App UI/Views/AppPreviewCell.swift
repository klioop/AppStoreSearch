//
//  AppPreviewCell.swift
//  AppStoreSearchiOS
//
//  Created by Lee Sam on 2023/09/17.
//

import UIKit
import SnapKit

public final class AppPreviewCell: UITableViewCell {
    
    var title: String {
        get { label.text ?? "" }
        set { label.text = newValue }
    }
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    public var gallery: UICollectionView! {
        didSet { layout() }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        separatorInset = .init(top: 0, left: 0, bottom: 0, right: -1)
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
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview().inset(20)
            $0.height.equalTo(UIScreen.main.bounds.height * 0.6)
        }
    }
}
