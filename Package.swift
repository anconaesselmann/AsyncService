// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "AsyncService",
    platforms: [
        .macOS(.v13),
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "AsyncService",
            targets: ["AsyncService"]),
    ],
    targets: [
        .target(
            name: "AsyncService"),
        .testTarget(
            name: "AsyncServiceTests",
            dependencies: ["AsyncService"]),
    ]
)
