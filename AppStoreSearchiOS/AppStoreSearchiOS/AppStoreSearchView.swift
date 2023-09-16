//
//  AppStoreSearchView.swift
//  AppStoreSearchiOS
//
//  Created by Lee Sam on 2023/09/16.
//

import UIKit
import SnapKit

final class AppStoreSearchView: UIView {
    
    var title: String {
        get { titleLabel.text ?? "" }
        set { titleLabel.text = newValue }
    }
    
    var placeholder: String {
        get { searchBar.placeholder ?? "" }
        set { searchBar.placeholder = newValue }
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    private lazy var searchBar: UISearchBar = {
        let search = UISearchBar()
        search.searchBarStyle = .minimal
        search.delegate = self
        return search
    }()
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle")
        return imageView
    }()
    
    private var topPadding: CGFloat { 20 }
    private var horizontalPadding: CGFloat { 20 }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        [titleLabel, searchBar, profileImageView].forEach(addSubview)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(topPadding)
            $0.leading.equalToSuperview().offset(20)
        }
        searchBar.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(horizontalPadding)
            $0.bottom.equalToSuperview().inset(20)
        }
        profileImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(horizontalPadding)
            $0.trailing.equalToSuperview().inset(horizontalPadding)
            $0.width.height.equalTo(36)
        }
    }
    
    required init?(coder: NSCoder) { nil }
}

extension AppStoreSearchView: UISearchBarDelegate {}
