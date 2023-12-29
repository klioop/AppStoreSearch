//
//  UIViewController+snapshot.swift
//  TeuidaTests
//
//  Created by Lee Sam on 2022/11/17.
//  Copyright © 2022 Teuida. All rights reserved.
//


import XCTest

extension UIViewController {
    func snapshot(for configuration: SnapshotConfiguration) -> UIImage {
        SnapshotWindow(configuration: configuration, root: self).snapshot()
    }
}

struct SnapshotConfiguration {
    let size: CGSize
    let safeAreaInset: UIEdgeInsets
    let layoutMargins: UIEdgeInsets
    let traitCollection: UITraitCollection
    
    static func iPhone11(style: UIUserInterfaceStyle) -> SnapshotConfiguration {
        return SnapshotConfiguration(
            size: .init(width: 414, height: 896),
            safeAreaInset: .init(top: 48, left: 0, bottom: 34, right: 0),
            layoutMargins: .init(top: 48, left: 20, bottom: 34, right: 20),
            traitCollection: UITraitCollection(
                traitsFrom: [
                    .init(forceTouchCapability: .available),
                    .init(layoutDirection: .leftToRight),
                    .init(horizontalSizeClass: .compact),
                    .init(verticalSizeClass: .regular),
                    .init(displayGamut: .P3),
                    .init(userInterfaceIdiom: .phone),
                    .init(preferredContentSizeCategory: .medium),
                    .init(displayScale: 2),
                    .init(userInterfaceStyle: style)
                ]
            )
        )
    }
}

class SnapshotWindow: UIWindow {
    var configuration: SnapshotConfiguration = .iPhone11(style: .light)
    
    convenience init(configuration: SnapshotConfiguration, root: UIViewController) {
        self.init(frame: .init(origin: .zero, size: configuration.size))
        self.configuration = configuration
        self.layoutMargins = configuration.layoutMargins
        self.rootViewController = root
        self.isHidden = false
        root.view.layoutMargins = configuration.layoutMargins
    }
    
    override var traitCollection: UITraitCollection {
        UITraitCollection(traitsFrom: [super.traitCollection, configuration.traitCollection])
    }
    
    override var safeAreaInsets: UIEdgeInsets {
        configuration.safeAreaInset
    }
    
    func snapshot() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds, format: .init(for: configuration.traitCollection))
        return renderer.image { action in
            layer.render(in: action.cgContext)
        }
    }
}
