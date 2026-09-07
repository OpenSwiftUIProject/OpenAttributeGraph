import ProjectDescription

// Keep remote caches disabled to reduce metered network traffic.
let tuist = Tuist(
    fullHandle: "OpenSwiftUIProject/openattributegraph",
    xcodeCache: .xcodeCache(
        upload: false
    ),
    project: .tuist(
        generationOptions: .options(
            optionalAuthentication: true,
            enableCaching: false,
            manifestEnvironment: [
                "OPENSWIFTUI_*",
                "OPENATTRIBUTEGRAPH_*",
            ]
        ),
        cacheOptions: .options(storages: [.local])
    )
)
