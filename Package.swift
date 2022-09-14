// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CoreNestore",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "CoreNestore",
            targets: ["CoreNestore"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "CoreNestore",
            dependencies: []),
        .testTarget(
            name: "CoreNestoreTests",
            dependencies: ["CoreNestore"]),
    ]
)
