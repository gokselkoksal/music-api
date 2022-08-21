// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "music-api",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6),
    ],
    products: [
        .library(
            name: "MusicAPI",
            targets: ["MusicAPI"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "MusicAPI",
            dependencies: []),
        .testTarget(
            name: "MusicAPITests",
            dependencies: ["MusicAPI"],
            resources: [
                .process("Resources")
            ]),
    ]
)
