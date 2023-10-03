// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "KRK_APICommon",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
        .tvOS(.v16)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "KRK_APICommon",
            targets: ["KRK_APICommon"]),
    ],
    dependencies: [
        .package(name: "KRK_Common", path: "../KRK_Common")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "KRK_APICommon",
            dependencies: ["KRK_Common"]
        ),
        .testTarget(
            name: "KRK_APICommonTests",
            dependencies: ["KRK_APICommon"]),
    ]
)
