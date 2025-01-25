// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NavigationKit",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "NavigationKit",
            targets: ["NavigationKit"]),
    ],
    targets: [
        .target(
            name: "NavigationKit",
            dependencies: []
        ),
        .testTarget(
            name: "NavigationKitTests",
            dependencies: ["NavigationKit"]
        )
    ]
)
