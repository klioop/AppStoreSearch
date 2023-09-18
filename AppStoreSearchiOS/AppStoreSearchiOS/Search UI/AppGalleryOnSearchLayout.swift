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
    private static var minusSpacing: CGFloat {
        interItemSpacing * 2 + horizontalPadding * 2
    }
    
    private static var itemSize: CGFloat {
        (UIScreen.main.bounds.width - (minusSpacing)) / 3
    }
    
    public static func layout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { _, _ in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .absolute(itemSize),
                heightDimension: .fractionalHeight(1.0)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitems: [item]
            )
            group.interItemSpacing = .fixed(interItemSpacing)
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
    }
}
