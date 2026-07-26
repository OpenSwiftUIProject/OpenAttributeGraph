// swift-tools-version: 6.2

import PackageDescription

#if TUIST
import ProjectDescription

let indexStoreDisabledSettings: SettingsDictionary = [
    // Swift 6.2.4 crashes while indexing C++ interop package targets.
    "COMPILER_INDEX_STORE_ENABLE": "NO",
]

let packageSettings = PackageSettings(
    baseSettings: .settings(base: indexStoreDisabledSettings)
)
#endif

let package = Package(
    name: "ExampleDependencies",
    dependencies: []
)
