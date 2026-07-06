// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "SwiftUIToolz",
    platforms: [.macOS(.v10_15)],
    products: [
        .library(
            name: "SwiftUIToolz",
            targets: ["SwiftUIToolz"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/nohype-ai/SwiftUIToolzOLD.git",
            exact: "0.3.9"
        ),
        .package(
            url: "https://github.com/nohype-ai/GetLaid.git",
            exact: "4.0.0"
        ),
        .package(
            url: "https://github.com/nohype-ai/SwiftObserver.git",
            exact: "7.0.9"
        ),
        .package(
            url: "https://github.com/nohype-ai/FoundationToolz.git",
            exact: "0.3.1"
        ),
        .package(
            url: "https://github.com/nohype-ai/SwiftyToolz.git",
            exact: "0.5.1"
        ),
    ],
    targets: [
        .target(
            name: "SwiftUIToolz",
            dependencies: [
                "SwiftUIToolzOLD",
                "GetLaid",
                "FoundationToolz",
                "SwiftObserver",
                "SwiftyToolz",
            ],
            path: "Code"
        ),
    ]
)
