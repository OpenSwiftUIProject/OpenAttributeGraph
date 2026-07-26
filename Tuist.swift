import ProjectDescription

let tuist = Tuist(
    fullHandle: "OpenSwiftUIProject/openattributegraph",
    xcodeCache: .xcodeCache(
        upload: Environment.isCI
    ),
    project: .tuist(
        generationOptions: .options(
            enableCaching: true,
            manifestEnvironment: [
                "OPENSWIFTUI_*",
                "OPENATTRIBUTEGRAPH_*",
            ]
        )
    )
)
