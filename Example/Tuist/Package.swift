// swift-tools-version: 6.3

import PackageDescription

#if TUIST
import ProjectDescription

let packageSettings = PackageSettings(
    baseSettings: .settings(
        base: [
            // Keep local compilation artifacts outside temporary CI build directories.
            "COMPILATION_CACHE_ENABLE_CACHING": "YES",
            "COMPILATION_CACHE_CAS_PATH": "$(HOME)/Library/Developer/Xcode/DerivedData/CompilationCache.noindex",
            "COMPILATION_CACHE_KEEP_CAS_DIRECTORY": "YES",
            "COMPILATION_CACHE_REMOTE_SERVICE_PATH": "",
            "COMPILATION_CACHE_ENABLE_PLUGIN": "NO",
        ]
    )
)
#endif

let package = Package(
    name: "ExampleDependencies",
    dependencies: [
        .package(path: "../../"),
        .package(url: "https://github.com/apple/swift-numerics", from: "1.1.1"),
    ]
)
