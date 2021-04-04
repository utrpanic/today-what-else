// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FeedReaderLib",
    platforms: [.iOS(.v14), .macOS(.v11)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "FeedReaderLib",
            targets: ["Model", "Toolbox", "View"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
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
            dependencies: ["Model", "Toolbox"]),
    ]
)
