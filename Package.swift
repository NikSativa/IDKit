// swift-tools-version:5.9
// swiftformat:disable all
import PackageDescription

let package = Package(
    name: "NAnyID",
    platforms: [
        .iOS(.v13),
        .macOS(.v11),
        .macCatalyst(.v13),
        .visionOS(.v1),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(name: "NAnyID", targets: ["NAnyID"]),
        .library(name: "NAnyIDTestHelpers", targets: ["NAnyIDTestHelpers"])
    ],
    dependencies: [
        .package(url: "https://github.com/NikSativa/NSpry.git", .upToNextMajor(from: "2.1.4"))
    ],
    targets: [
        .target(name: "NAnyID",
                dependencies: [
                ],
                path: "Source",
                resources: [
                    .copy("../PrivacyInfo.xcprivacy")
                ]),
        .target(name: "NAnyIDTestHelpers",
                dependencies: [
                    "NAnyID",
                    "NSpry"
                ],
                path: "TestHelpers",
                resources: [
                    .copy("../PrivacyInfo.xcprivacy")
                ]),
        .testTarget(name: "NAnyIDTests",
                    dependencies: [
                        "NAnyID",
                        "NAnyIDTestHelpers",
                        "NSpry"
                    ],
                    path: "Tests")
    ]
)
