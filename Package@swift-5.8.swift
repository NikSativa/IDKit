// swift-tools-version:5.8
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
        .library(name: "IDKit", targets: ["IDKit"])
    ],
    dependencies: [
        .package(url: "https://github.com/NikSativa/SpryKit.git", .upToNextMinor(from: "3.0.2"))
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
