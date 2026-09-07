import ProjectDescription

let project = Project(
    name: "Example",
    settings: .settings(
        base: [
            // Keep local compilation artifacts outside temporary CI build directories.
            "COMPILATION_CACHE_ENABLE_CACHING": "YES",
            "COMPILATION_CACHE_CAS_PATH": "$(HOME)/Library/Developer/Xcode/DerivedData/CompilationCache.noindex",
            "COMPILATION_CACHE_KEEP_CAS_DIRECTORY": "YES",
            "COMPILATION_CACHE_REMOTE_SERVICE_PATH": "",
            "COMPILATION_CACHE_ENABLE_PLUGIN": "NO",
        ]
    ),
    targets: [
        .target(
            name: "Example",
            destinations: [.mac],
            product: .commandLineTool,
            bundleId: "org.OpenSwiftUIProject.OpenAttributeGraph.Example",
            deploymentTargets: .macOS("15.0"),
            sources: ["Sources/**"],
            dependencies: [
                .sdk(name: "c++", type: .library),
                .external(name: "OpenAttributeGraph"),
            ]
        ),
    ]
)
