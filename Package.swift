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
    targets: [
        .target(
            name: "SwiftGeo"
        ),
        .testTarget(
            name: "SwiftGeoTests",
            dependencies: ["SwiftGeo"]
        ),
    ]
)
