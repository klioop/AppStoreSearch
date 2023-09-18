//
//  AppGalleryOnSearchLayout.swift
//  AppStoreSearchiOS
//
//  Created by Lee Sam on 2023/09/18.
//

import UIKit

public final class AppGalleryOnSearchLayout {
    private init() {}
    
    private static var interItemSpacing: CGFloat { 10 }
    private static var horizontalPadding: CGFloat { 20 }
    
    private static var groupWidth: CGFloat {
        (UIScreen.main.bounds.width - (interItemSpacing + horizontalPadding)) / 3
    }
    
    public static func layout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { _, _ in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .absolute(groupWidth),
                heightDimension: .fractionalHeight(1.0)
            )
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: groupSize,
                subitems: [item]
            )
            group.interItemSpacing = .fixed(interItemSpacing)
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
    }
}
