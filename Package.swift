// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "PublisherView",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(name: "PublisherView", targets: ["PublisherView"]),
    ],
    targets: [
        .target(name: "PublisherView")
    ]
)
