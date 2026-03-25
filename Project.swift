import ProjectDescription

// MARK: - Process Headers Script

let processHeadersScript: TargetScript = .pre(
    script: """
    Scripts/Xcode/process_headers.sh
    """,
    name: "Process Headers",
    inputFileListPaths: [
        "Scripts/Xcode/process_headers_inputs.xcfilelist",
    ],
    outputFileListPaths: [
        "Scripts/Xcode/process_headers_outputs.xcfilelist",
    ]
)

// MARK: - Project

let project = Project(
    name: "OpenAttributeGraph",
    settings: .settings(
        configurations: [
            .debug(name: .debug, xcconfig: "Configs/Common.xcconfig"),
            .release(name: .release, xcconfig: "Configs/Common.xcconfig"),
        ]
    ),
    targets: [
        .target(
            name: "OpenAttributeGraph",
            destinations: [.iPhone, .iPad, .mac, .appleVision],
            product: .framework,
            bundleId: "org.OpenSwiftUIProject.OpenAttributeGraph",
            deploymentTargets: .multiplatform(
                iOS: "18.0",
                macOS: "15.0",
                visionOS: "2.0"
            ),
            sources: .sourceFilesList(globs: [
                .glob(
                    "Sources/Platform/**",
                    excluding: ["Sources/Platform/README.md"]
                ),
                .glob(
                    "Sources/Utilities/**",
                    excluding: [
                        "Sources/Utilities/README.md",
                        "Sources/Utilities/include/SwiftBridging/README.md",
                    ]
                ),
                .glob(
                    "Sources/OpenAttributeGraphCxx/**",
                    excluding: [
                        "Sources/OpenAttributeGraphCxx/include/OpenAttributeGraphCxx/Vector/vector.tpp",
                        "Sources/OpenAttributeGraphCxx/include/SwiftBridging/README.md",
                    ]
                ),
                "Sources/OpenAttributeGraph/**",
            ]),
            scripts: [processHeadersScript],
            dependencies: [
                .sdk(name: "libz", type: .library),
            ],
            settings: .settings(
                configurations: [
                    .debug(name: .debug, xcconfig: "Configs/OpenAttributeGraph.xcconfig"),
                    .release(name: .release, xcconfig: "Configs/OpenAttributeGraph.xcconfig"),
                ]
            )
        ),
    ]
)
