// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Platform",
  platforms: [.iOS(.v18)],
  products: [
    .library(
      name: "Platform",
      targets: [
        "ComposableArchitecture",
        "Platform"
      ]),
  ],
  targets: [
    .target(
      name: "ComposableArchitecture",
      path: "ComposableArchitecture"
    ),
    .testTarget(
      name: "ComposableArchitectureTests",
      dependencies: ["ComposableArchitecture"],
      path: "ComposableArchitectureTests"
    ),
    .target(
      name: "Platform"),
    .testTarget(
      name: "PlatformTests",
      dependencies: ["Platform"]
    ),
  ]
)
