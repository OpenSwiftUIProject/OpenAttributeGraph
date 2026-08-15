import ProjectDescription

let tuist = Tuist(
    fullHandle: "OpenSwiftUIProject/openattributegraph",
    xcodeCache: .xcodeCache(
        upload: Environment.isCI
    ),
    project: .tuist(
        generationOptions: .options(
            optionalAuthentication: true,
            enableCaching: Environment.isCI,
            manifestEnvironment: [
                "OPENSWIFTUI_*",
                "OPENATTRIBUTEGRAPH_*",
            ]
        )
    )
)
