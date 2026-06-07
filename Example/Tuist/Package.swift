// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "ExampleDependencies",
    dependencies: [
        .package(path: "../../"),
    ]
)
