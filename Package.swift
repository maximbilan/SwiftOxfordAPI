// swift-tools-version:4.2

import PackageDescription

let package = Package(
    name: "SwiftOxfordAPI",
    products: [
        .library(
            name: "SwiftOxfordAPI",
            targets: ["SwiftOxfordAPI"]),
    ],
    targets: [
        .target(
            name: "SwiftOxfordAPI",
            path: "Sources"),
    ]
)
