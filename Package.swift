// swift-tools-version:6.0
// swiftformat:disable all
import PackageDescription

let package = Package(
    name: "IDKit",
    platforms: [
        .iOS(.v16),
        .macOS(.v14),
        .macCatalyst(.v16),
        .visionOS(.v1),
        .tvOS(.v16),
        .watchOS(.v9)
    ],
    products: [
        .library(name: "IDKit", targets: ["IDKit"])
    ],
    dependencies: [
        .package(url: "https://github.com/NikSativa/SpryKit.git", from: "3.1.0")
    ],
    targets: [
        .target(name: "IDKit",
                dependencies: [
                ],
                path: "Source",
                resources: [
                    .process("PrivacyInfo.xcprivacy")
                ]),
        .testTarget(name: "IDKitTests",
                    dependencies: [
                        "IDKit",
                        "SpryKit"
                    ],
                    path: "Tests")
    ]
)
