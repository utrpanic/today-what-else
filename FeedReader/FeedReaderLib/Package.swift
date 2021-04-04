// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FeedReaderLib",
    platforms: [.iOS(.v14), .macOS(.v11)],
    products: [
        .library(
            name: "FeedReaderLib",
            targets: ["Model", "Toolbox", "View"]),
        .library(
            name: "MockFeedReaderLib",
            targets: ["MockService"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "MockService",
            dependencies: ["Model"],
            resources: [.process("Fixtures")]
        ),
        .target(
            name: "Model",
            dependencies: ["Toolbox"]),
        .target(
            name: "Toolbox",
            dependencies: []),
        .target(
            name: "View",
            dependencies: []),
        .testTarget(
            name: "ModelTests",
            dependencies: ["MockService", "Model"]),
    ]
)
