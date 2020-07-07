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
      targets: ["SpeculidKit", "CairoSVG"]
    ),
    .executable(name: "spcld", targets: ["SpeculidKit.Command", "CairoSVG"])
    
  ],
  dependencies: [
    // Dependencies declare other packages that this package depends on.
    
    .package(path: "./packages/AssetLib"),
    .package(path: "./packages/GampKit"),
    .package(path: "./packages/SwiftDraw"),
    .package(url: "https://github.com/apple/swift-argument-parser", from: "0.2.0"),
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages which this package depends on.
    .target(
      name: "SpeculidKit",
      dependencies: ["AssetLib", "GampKit", "SwiftDraw"]
    ),
    .target(
      name: "SpeculidKit.Command",
      dependencies: ["SpeculidKit",
                     .product(name: "ArgumentParser", package: "swift-argument-parser")]
    ),
    .binaryTarget(
        name: "CairoSVG",
        path: "packages/CairoSVG/build/CairoSVG.xcframework"
        //url: "https://github.com/brightdigit/CairoSVG/releases/download/0.1.0-alpha.1/CairoSVG.xcframework.zip",
        //checksum: "3a1f7ba992691e7c4b191c79f8e8cb4318d61811fc47dd0e09314c321fac023a"
    ),
    .testTarget(
      name: "SpeculidKitTests",
      dependencies: ["SpeculidKit"]
    )
  ]
)
