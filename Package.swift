// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-geo",
    platforms: [.iOS(.v17), .macOS(.v14)],
    products: [
        .library(
            name: "SwiftGeo",
            targets: ["SwiftGeo"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-testing.git", from: "0.11.0"),
    ],
    targets: [
        .target(
            name: "SwiftGeo"
        ),
        .testTarget(
            name: "SwiftGeoTests",
            dependencies: ["SwiftGeo", .product(name: "Testing", package: "swift-testing")]
        ),
    ]
)
