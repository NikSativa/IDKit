// swift-tools-version:5.3
// swiftformat:disable all
import PackageDescription

let package = Package(
    name: "NAnyID",
    platforms: [.iOS(.v13), .macOS(.v10_15)],
    products: [
        .library(name: "NAnyID", targets: ["NAnyID"]),
        .library(name: "NAnyIDTestHelpers", targets: ["NAnyIDTestHelpers"])
    ],
    dependencies: [
        .package(url: "https://github.com/NikSativa/NSpry.git", .upToNextMajor(from: "1.2.10")),
        .package(url: "git@github.com:Quick/Quick.git", .upToNextMajor(from: "6.1.0")),
        .package(url: "git@github.com:Quick/Nimble.git", .upToNextMajor(from: "11.2.1"))
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
