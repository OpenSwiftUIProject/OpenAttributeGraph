import ProjectDescription

let indexStoreDisabledSettings: SettingsDictionary = [
    // Swift 6.2.4 crashes while indexing C++ interop package targets.
    "COMPILER_INDEX_STORE_ENABLE": "NO",
]

let project = Project(
    name: "Example",
    settings: .settings(base: indexStoreDisabledSettings),
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
            ],
            settings: .settings(base: indexStoreDisabledSettings)
        ),
    ]
)
