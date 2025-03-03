// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Feature",
  platforms: [.iOS(.v18)],
  products: [
    .library(
      name: "Feature",
      targets: [
        "Feature",
        "Counter",
        "FavoritePrimes",
        "PrimeModal",
      ]),
  ],
  dependencies: [
    .package(path: "../Platform")
  ],
  targets: [
    .target(
      name: "Feature"),
    .testTarget(
      name: "FeatureTests",
      dependencies: ["Feature"]
    ),
    .target(
      name: "Counter",
      dependencies: [
        "PrimeModal",
        .product(name: "Platform", package: "Platform"),
      ],
      path: "Counter"
    ),
    .testTarget(
      name: "CounterTests",
      dependencies: ["Counter"],
      path: "CounterTests"
    ),
    .target(
      name: "FavoritePrimes",
      dependencies: [
        .product(name: "Platform", package: "Platform"),
      ],
      path: "FavoritePrimes"
    ),
    .testTarget(
      name: "FavoritePrimesTests",
      dependencies: ["FavoritePrimes"],
      path: "FavoritePrimesTests"
    ),
    .target(
      name: "PrimeModal",
      dependencies: [
        .product(name: "Platform", package: "Platform"),
      ],
      path: "PrimeModal"
    ),
    .testTarget(
      name: "PrimeModalTests",
      dependencies: ["PrimeModal"],
      path: "PrimeModalTests"
    ),
  ]
)
