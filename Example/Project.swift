import ProjectDescription

let openAttributeGraphModuleSearchSettings: SettingsDictionary = [
    "LD_RUNPATH_SEARCH_PATHS": "$(inherited) @loader_path",
    "SWIFT_INCLUDE_PATHS": "$(inherited) $(SRCROOT)/../Sources/OpenAttributeGraphCxx/include",
]

let project = Project(
    name: "Example",
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
                .project(target: "OpenAttributeGraph", path: ".."),
            ],
            settings: .settings(base: openAttributeGraphModuleSearchSettings)
        ),
    ]
)
