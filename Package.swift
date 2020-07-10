// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "SpeculidKit",
    platforms: [
         .macOS(.v10_12), .iOS(.v10),
      ],
  products: [
    // Products define the executables and libraries produced by a package, and make them visible to other packages.
    .library(
      name: "SpeculidKit",
      targets: ["SpeculidKit"]
    ),
    .executable(name: "spcld", targets: ["SpeculidKit.Command"])
    
  ],
  dependencies: [
    // Dependencies declare other packages that this package depends on.
    
    .package(path: "./packages/AssetLib"),
    .package(path: "./packages/GampKit"),
    .package(path: "./packages/SwiftDraw"),
    .package(path: "./packages/CairoSVG"),
    .package(url: "https://github.com/apple/swift-argument-parser", from: "0.2.0"),
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages which this package depends on.
    .target(
      name: "SpeculidKit",
      dependencies: ["AssetLib", "GampKit", "SwiftDraw", "CairoSVG"]
    ),
    .target(
      name: "SpeculidKit.Command",
      dependencies: ["SpeculidKit",
                     .product(name: "ArgumentParser", package: "swift-argument-parser")]
    ),
    .testTarget(
      name: "SpeculidKitTests",
      dependencies: ["SpeculidKit"]
    )
  ]
)
