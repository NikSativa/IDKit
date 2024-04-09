// swift-tools-version:5.6
// swiftformat:disable all
import PackageDescription

let package = Package(
    name: "IDKit",
    platforms: [
        .iOS(.v13),
        .macOS(.v11),
        .macCatalyst(.v13),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(name: "IDKit", targets: ["IDKit"]),
        .library(name: "IDKitTestHelpers", targets: ["IDKitTestHelpers"])
    ],
    dependencies: [
        .package(url: "https://github.com/NikSativa/SpryKit.git", .upToNextMajor(from: "2.1.4"))
    ],
    targets: [
        .target(name: "IDKit",
                dependencies: [
                ],
                path: "Source",
                resources: [
                    .copy("../PrivacyInfo.xcprivacy")
                ]),
        .target(name: "IDKitTestHelpers",
                dependencies: [
                    "IDKit",
                    "SpryKit"
                ],
                path: "TestHelpers",
                resources: [
                    .copy("../PrivacyInfo.xcprivacy")
                ]),
        .testTarget(name: "IDKitTests",
                    dependencies: [
                        "IDKit",
                        "IDKitTestHelpers",
                        "SpryKit"
                    ],
                    path: "Tests")
    ]
)
