// swift-tools-version:5.9
// swiftformat:disable all
import PackageDescription

let package = Package(
    name: "IDKit",
    platforms: [
        .iOS(.v13),
        .macOS(.v11),
        .macCatalyst(.v13),
        .visionOS(.v1),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(name: "IDKit", targets: ["IDKit"])
    ],
    dependencies: [
        .package(url: "https://github.com/NikSativa/SpryKit.git", .upToNextMajor(from: "3.0.0"))
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
