import ProjectDescription

let tuist = Tuist(
    fullHandle: "OpenSwiftUIProject/openattributegraph",
    xcodeCache: .xcodeCache(
        upload: Environment.isCI
    ),
    project: .tuist(
        generationOptions: .options(
            enableCaching: Environment.isCI,
            manifestEnvironment: [
                "OPENSWIFTUI_*",
                "OPENATTRIBUTEGRAPH_*",
            ]
        )
    )
)
