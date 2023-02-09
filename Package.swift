// swift-tools-version:5.3

import PackageDescription

// swiftformat:disable all
let package = Package(
    name: "NAnyID",
    platforms: [.iOS(.v12), .macOS(.v10_13)],
    products: [
        .library(name: "NAnyID", targets: ["NAnyID"]),
        .library(name: "NAnyIDTestHelpers", targets: ["NAnyIDTestHelpers"])
    ],
    dependencies: [
        .package(url: "https://github.com/NikSativa/NSpry.git", .upToNextMajor(from: "1.2.10")),
        .package(url: "https://github.com/Quick/Quick.git", .upToNextMajor(from: "5.0.1")),
        .package(url: "https://github.com/Quick/Nimble.git", .upToNextMajor(from: "10.0.0"))
    ],
    targets: [
        .target(name: "NAnyID",
                dependencies: [
                ],
                path: "Source"),
        .target(name: "NAnyIDTestHelpers",
                dependencies: [
                    "NAnyID",
                    "NSpry"
                ],
                path: "TestHelpers"),
        .testTarget(name: "NAnyIDTests",
                    dependencies: [
                        "NAnyID",
                        "NAnyIDTestHelpers",
                        "Nimble",
                        "Quick",
                        "NSpry",
                        .product(name: "NSpry_Nimble", package: "NSpry")
                    ],
                    path: "Tests")
    ]
)
