// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "SwiftUIToolz",
    platforms: [
        .iOS(.v13), .macOS(.v10_15), .tvOS(.v13), .watchOS(.v6)
    ],
    products: [
        .library(
            name: "SwiftUIToolz",
            targets: ["SwiftUIToolz"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/nohype-ai/SwiftObserver.git",
            exact: "8.0.3"
        ),
        .package(
            url: "https://github.com/nohype-ai/SwiftyToolz.git",
            exact: "0.5.8"
        ),
    ],
    targets: [
        .target(
            name: "SwiftUIToolz",
            dependencies: [
                .product(name: "CombineObserver",
                         package: "SwiftObserver"),
                "SwiftObserver",
                "SwiftyToolz"
            ],
            path: "Code"
        ),
    ]
)
