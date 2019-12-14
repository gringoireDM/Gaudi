// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "Gaudi",
    platforms: [
      .iOS(.v11)
    ],
    products: [
        .library(
            name: "Gaudi",
            targets: ["Gaudi"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Gaudi",
            dependencies: []),
        .testTarget(
            name: "GaudiTests",
            dependencies: ["Gaudi"]),
    ]
)
