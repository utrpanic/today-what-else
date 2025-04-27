// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "RepeaterLibrary",
  platforms: [
    .iOS(.v18),
  ],
  products: [
    .library(
      name: "RepeaterLibrary",
      targets: ["RepeaterModel", "RepeaterView", "RepeaterViewModel"]
      ),
  ],
  targets: [
    .target(
      name: "RepeaterModel",
      path: "Model"
    ),
    .target(
      name: "RepeaterView",
      dependencies: [
        "RepeaterModel",
        "RepeaterViewModel"
      ]
      ,path: "View"
    ),
    .target(
      name: "RepeaterViewModel",
      dependencies: [
        "RepeaterModel"
      ]
      ,path: "ViewModel"
    ),
  ]
)
