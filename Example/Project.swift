import ProjectDescription

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
                .external(name: "OpenAttributeGraph"),
            ]
        ),
    ]
)
