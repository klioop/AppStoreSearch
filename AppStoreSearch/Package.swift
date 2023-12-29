// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "AppStoreSearch",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "AppStoreSearch",
            targets: ["AppStoreSearch"]
        )
    ],
    targets: [
        .target(
            name: "AppStoreSearch"),
        .testTarget(
            name: "AppStoreSearchTests",
            dependencies: ["AppStoreSearch"]
        ),
        .testTarget(
            name: "AppStoreSearchAPIEndToEndTests",
            dependencies: ["AppStoreSearch"]
        )
    ]
)
