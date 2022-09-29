// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "ReadySetBoole",
  dependencies: [
    // Dependencies declare other packages that this package depends on.
    // .package(url: /* package url */, from: "1.0.0"),
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages this package depends on.
    .executableTarget(name: "Ex00", dependencies: ["Exercises", "Utils"]),
    .executableTarget(name: "Ex01", dependencies: ["Exercises", "Utils"]),
    .testTarget(name: "Ex00Tests", dependencies: ["Exercises", "Ex00"]),
    .testTarget(name: "Ex01Tests", dependencies: ["Exercises", "Ex01"]),
    .target(name: "Exercises"),
    .target(name: "Utils"),
  ]
)
