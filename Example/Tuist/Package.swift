// swift-tools-version: 6.3

import PackageDescription

#if TUIST
import ProjectDescription

let packageSettings = PackageSettings()
#endif

let package = Package(
    name: "ExampleDependencies",
    dependencies: [
        .package(path: "../../"),
        .package(url: "https://github.com/apple/swift-numerics", from: "1.1.1"),
    ]
)
