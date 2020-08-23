// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "PublisherView",
    platforms: [
        .iOS(.v14),
        .macOS(.v11),
        .tvOS(.v14),
        .watchOS(.v7)
    ],
    products: [
        .library(name: "PublisherView", targets: ["PublisherView"]),
    ],
    targets: [
        .target(name: "PublisherView")
    ]
)
