//
//  AppStoreSearchView.swift
//  AppStoreSearchiOS
//
//  Created by Lee Sam on 2023/09/16.
//

import UIKit
import SnapKit

public final class AppStoreSearchView: UIView {
    
    public var title: String {
        get { titleLabel.text ?? "" }
        set { titleLabel.text = newValue }
    }
    
    public var placeholder: String {
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
        search.searchTextField.clearButtonMode = .whileEditing
        return search
    }()
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle")
        return imageView
    }()
    
    private var topPadding: CGFloat { 20 }
    private var horizontalPadding: CGFloat { 20 }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        [titleLabel, searchBar, profileImageView].forEach(addSubview)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(topPadding)
            $0.leading.equalToSuperview().offset(20)
        }
        searchBar.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().inset(20)
        }
        profileImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(horizontalPadding)
            $0.trailing.equalToSuperview().inset(horizontalPadding)
            $0.width.height.equalTo(36)
        }
    }
    
    public required init?(coder: NSCoder) { nil }
    
    public var onTapSearch: ((String) -> Void)?
    public var onTextChange: ((String) -> Void)?
    public var onTapCancel: (() -> Void)?
}

extension AppStoreSearchView: UISearchBarDelegate {
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        hiddenCancelButtonAndKeyboard()
        onTapSearch?(searchBar.text ?? "")
    }
    
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        onTapCancel?()
        searchBar.text = ""
        hiddenCancelButtonAndKeyboard()
    }
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        onTextChange?(searchBar.text ?? "")
        hiddenCancelButton(upon: searchBar.text)
    }
    
    public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        onTapCancel?()
        hiddenCancelButton(upon: searchBar.text)
    }
    
    // MARK: - Helpers
    
    private func hiddenCancelButtonAndKeyboard() {
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
    }
    
    private func hiddenCancelButton(upon searchTerm: String?) {
        guard let term = searchBar.text else { return }
        searchBar.showsCancelButton = !term.isEmpty
    }
}
