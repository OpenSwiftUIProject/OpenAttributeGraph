import ProjectDescription

// MARK: - Constants

let destinations: Destinations = [.iPhone, .iPad, .mac, .appleVision]
let useComputeBackend = Environment.openattributegraphCompute.getBoolean(default: false)
let platformTargetName = "OpenAttributeGraphPlatform"
let utilitiesTargetName = "OpenAttributeGraphUtilities"
let commonConfigurations: [Configuration] = [
    .debug(name: "Debug", xcconfig: "Configs/Common.xcconfig"),
    .release(name: "Release", xcconfig: "Configs/Common.xcconfig"),
]
let nativeHeaderSearchSettings: SettingsDictionary = [
    "HEADER_SEARCH_PATHS": "$(inherited) $(SRCROOT)/Sources/Platform/include $(SRCROOT)/Sources/Utilities/include $(SRCROOT)/Sources/OpenAttributeGraphCxx/include",
    "USER_HEADER_SEARCH_PATHS": "$(inherited) $(SRCROOT)/Sources/OpenAttributeGraphCxx",
]
let cxxInteropSettings: SettingsDictionary = [
    "GCC_PREPROCESSOR_DEFINITIONS": "$(inherited) SWIFT_TESTING=1",
    "OTHER_SWIFT_FLAGS": "$(inherited) -cxx-interoperability-mode=default -Xcc -std=c++20",
    "SWIFT_INCLUDE_PATHS": "$(inherited) $(SRCROOT)/Sources/Platform/include $(SRCROOT)/Sources/Utilities/include $(SRCROOT)/Sources/OpenAttributeGraphCxx/include",
]
let openAttributeGraphShimsDependencies: [TargetDependency] = useComputeBackend
    ? [
        .external(name: "Compute"),
        .sdk(name: "c++", type: .library),
        .sdk(name: "Demangle", type: .swiftLibrary),
    ]
    : [
        .target(name: "OpenAttributeGraph"),
    ]
let openAttributeGraphShimsSettings: SettingsDictionary = useComputeBackend
    ? [
        "SWIFT_ACTIVE_COMPILATION_CONDITIONS": "$(inherited) OPENATTRIBUTEGRAPH_COMPUTE",
    ]
    : [:]

func commonSettings(base: SettingsDictionary = [:]) -> Settings {
    .settings(
        base: base,
        configurations: commonConfigurations,
        defaultSettings: .none
    )
}

// MARK: - Project

let project = Project(
    name: "OpenAttributeGraph",
    settings: .settings(
        configurations: commonConfigurations,
        defaultSettings: .none
    ),
    targets: [
        .target(
            name: platformTargetName,
            destinations: destinations,
            product: .staticLibrary,
            bundleId: "org.OpenSwiftUIProject.OpenAttributeGraph.Platform",
            sources: ["Sources/Platform/**/*.c"],
            headers: .headers(public: ["Sources/Platform/include/platform/**"]),
            settings: commonSettings(base: nativeHeaderSearchSettings)
        ),
        .target(
            name: utilitiesTargetName,
            destinations: destinations,
            product: .staticLibrary,
            bundleId: "org.OpenSwiftUIProject.OpenAttributeGraph.Utilities",
            sources: ["Sources/Utilities/**/*.cpp"],
            headers: .headers(public: ["Sources/Utilities/include/Utilities/**"]),
            dependencies: [
                .target(name: platformTargetName),
            ],
            settings: commonSettings(
                base: nativeHeaderSearchSettings.merging([
                    "PRODUCT_MODULE_NAME": "Utilities",
                ])
            )
        ),
        .target(
            name: "OpenAttributeGraphCxx",
            destinations: destinations,
            product: .staticLibrary,
            bundleId: "org.OpenSwiftUIProject.OpenAttributeGraph.Cxx",
            sources: [
                "Sources/OpenAttributeGraphCxx/**/*.c",
                "Sources/OpenAttributeGraphCxx/**/*.cpp",
                "Sources/OpenAttributeGraphCxx/**/*.mm",
            ],
            headers: .headers(
                public: [
                    "Sources/OpenAttributeGraphCxx/include/OpenAttributeGraph/**",
                    "Sources/OpenAttributeGraphCxx/include/OpenAttributeGraphCxx/**",
                ]
            ),
            dependencies: [
                .target(name: platformTargetName),
                .target(name: utilitiesTargetName),
                .sdk(name: "z", type: .library),
            ],
            settings: commonSettings(base: nativeHeaderSearchSettings)
        ),
        .target(
            name: "OpenAttributeGraph",
            destinations: destinations,
            product: .framework,
            bundleId: "org.OpenSwiftUIProject.OpenAttributeGraph",
            sources: [
                "Sources/OpenAttributeGraph/**",
            ],
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
                .target(name: "OpenAttributeGraphCxx"),
                .sdk(name: "c++", type: .library),
            ],
            settings: .settings(
                base: [
                    "DEFINES_MODULE": "NO",
                    "OTHER_LDFLAGS": "$(inherited) -force_load $(BUILT_PRODUCTS_DIR)/libOpenAttributeGraphCxx.a",
                ],
                configurations: [
                    .debug(name: "Debug", xcconfig: "Configs/OpenAttributeGraph.xcconfig"),
                    .release(name: "Release", xcconfig: "Configs/OpenAttributeGraph.xcconfig"),
                ],
                defaultSettings: .none
            )
        ),
        .target(
            name: "OpenAttributeGraphShims",
            destinations: destinations,
            product: .staticFramework,
            bundleId: "org.OpenSwiftUIProject.OpenAttributeGraph.Shims",
            sources: ["Sources/OpenAttributeGraphShims/**"],
            dependencies: openAttributeGraphShimsDependencies,
            settings: commonSettings(base: openAttributeGraphShimsSettings)
        ),
        .target(
            name: "UtilitiesTests",
            destinations: destinations,
            product: .unitTests,
            bundleId: "org.OpenSwiftUIProject.OpenAttributeGraph.UtilitiesTests",
            sources: ["Tests/UtilitiesTests/**/*.swift"],
            dependencies: [
                .target(name: utilitiesTargetName),
            ],
            settings: commonSettings(base: cxxInteropSettings)
        ),
        .target(
            name: "OpenAttributeGraphCxxTests",
            destinations: destinations,
            product: .unitTests,
            bundleId: "org.OpenSwiftUIProject.OpenAttributeGraph.CxxTests",
            sources: ["Tests/OpenAttributeGraphCxxTests/**/*.swift"],
            dependencies: [
                .target(name: "OpenAttributeGraphCxx"),
            ],
            settings: commonSettings(base: cxxInteropSettings)
        ),
        .target(
            name: "OpenAttributeGraphShimsTests",
            destinations: destinations,
            product: .unitTests,
            bundleId: "org.OpenSwiftUIProject.OpenAttributeGraph.ShimsTests",
            sources: ["Tests/OpenAttributeGraphShimsTests/**/*.swift"],
            dependencies: [
                .target(name: "OpenAttributeGraphShims"),
            ],
            settings: commonSettings()
        ),
        .target(
            name: "OpenAttributeGraphCompatibilityTests",
            destinations: destinations,
            product: .unitTests,
            bundleId: "org.OpenSwiftUIProject.OpenAttributeGraph.CompatibilityTests",
            sources: ["Tests/OpenAttributeGraphCompatibilityTests/**/*.swift"],
            dependencies: [
                .target(name: "OpenAttributeGraph"),
                .external(name: "Numerics"),
                .external(name: "RealModule"),
            ],
            settings: commonSettings()
        ),
    ]
)
