// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Feature",
  platforms: [.iOS(.v13)],
  products: [
    .library(name: "ComposableArchitecture", targets: ["ComposableArchitecture"]),
    .library(name: "Counter", targets: ["Counter"]),
    .library(name: "FavoritePrimes", targets: ["FavoritePrimes"]),
    .library(name: "PrimeModal", targets: ["PrimeModal"]),
  ],
  dependencies: [
  ],
  targets: [
    .target(
      name: "ComposableArchitecture",
      dependencies: []
    ),
    .testTarget(
      name: "ComposableArchitectureTests",
      dependencies: ["ComposableArchitecture"]
    ),
    .target(
      name: "Counter",
      dependencies: ["ComposableArchitecture", "PrimeModal"]
    ),
    .testTarget(
      name: "CounterTests",
      dependencies: ["Counter"]
    ),
    .target(
      name: "FavoritePrimes",
      dependencies: ["ComposableArchitecture"]
    ),
    .testTarget(
      name: "FavoritePrimesTests",
      dependencies: ["FavoritePrimes"]
    ),
    .target(
      name: "PrimeModal",
      dependencies: ["ComposableArchitecture"]
    ),
    .testTarget(
      name: "PrimeModalTests",
      dependencies: ["PrimeModal"]
    ),
  ]
)
