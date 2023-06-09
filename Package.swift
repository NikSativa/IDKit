// swift-tools-version:5.3
// swiftformat:disable all
import PackageDescription

let package = Package(
    name: "NAnyID",
    platforms: [
        .iOS(.v13),
        .macOS(.v11)
    ],
    products: [
        .library(name: "NAnyID", targets: ["NAnyID"]),
        .library(name: "NAnyIDTestHelpers", targets: ["NAnyIDTestHelpers"])
    ],
    dependencies: [
        .package(url: "git@github.com:NikSativa/NSpry.git", .upToNextMajor(from: "2.1.0"))
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
                        "NSpry"
                    ],
                    path: "Tests")
    ]
)
