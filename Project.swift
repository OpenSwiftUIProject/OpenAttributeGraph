import ProjectDescription

// MARK: - Constants

let destinations: Destinations = [.iPhone, .iPad, .mac, .appleVision]

// MARK: - Project

let project = Project(
    name: "OpenAttributeGraph",
    settings: .settings(
        configurations: [
            .debug(name: "Debug", xcconfig: "Configs/Common.xcconfig"),
            .release(name: "Release", xcconfig: "Configs/Common.xcconfig"),
        ],
        defaultSettings: .none
    ),
    targets: [
        .target(
            name: "OpenAttributeGraph",
            destinations: destinations,
            product: .framework,
            bundleId: "org.OpenSwiftUIProject.OpenAttributeGraph",
            sources: [
                "Sources/Platform/**",
                "Sources/Utilities/**",
                "Sources/OpenAttributeGraphCxx/**",
                "Sources/OpenAttributeGraph/**",
            ],
            headers: .headers(
                project: [
                    "Sources/OpenAttributeGraphCxx/include/**",
                    "Sources/Platform/include/**",
                    "Sources/Utilities/include/**",
                ]
            ),
            scripts: [
                .pre(
                    path: "Scripts/Xcode/process_headers.sh",
                    name: "Process Headers",
                    inputPaths: [
                        "$(SRCROOT)/Scripts/Xcode/process_headers.sh",
                    ],
                    inputFileListPaths: [
                        "Scripts/Xcode/process_headers_inputs.xcfilelist",
                    ],
                    outputPaths: [],
                    outputFileListPaths: [
                        "Scripts/Xcode/process_headers_outputs.xcfilelist",
                    ]
                ),
            ],
            dependencies: [
                .sdk(name: "z", type: .library),
            ],
            settings: .settings(
                base: [
                    "DEFINES_MODULE": "NO",
                ],
                configurations: [
                    .debug(name: "Debug", xcconfig: "Configs/OpenAttributeGraph.xcconfig"),
                    .release(name: "Release", xcconfig: "Configs/OpenAttributeGraph.xcconfig"),
                ],
                defaultSettings: .none
            )
        ),
    ]
)
