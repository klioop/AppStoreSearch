// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "AppStoreSearchiOS",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "AppStoreSearchiOS",
            targets: ["AppStoreSearchiOS"]
        ),
    ],
    dependencies: [
        .package(path: "../AppStoreSearch"),
        .package(url: "https://github.com/SnapKit/SnapKit.git", exact: "5.6.0")
    ],
    targets: [
        .target(
            name: "AppStoreSearchiOS",
            dependencies: ["AppStoreSearch", "SnapKit"]
        ),
        .testTarget(
            name: "AppStoreSearchiOSTests",
            dependencies: ["AppStoreSearchiOS"]
        ),
    ]
)
