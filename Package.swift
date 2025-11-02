// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import Foundation
import PackageDescription

// MARK: - Env Manager

@MainActor
final class EnvManager {
    static let shared = EnvManager()

    private var domains: [String] = []

    func register(domain: String) {
        domains.append(domain)
    }

    func envEnable(rawKey: String, default defaultValue: Bool, searchInDomain: Bool) -> Bool {
        if searchInDomain {
            for domain in domains {
                let key = "\(domain.uppercased())_\(rawKey)"
                guard let (value, result) = _envEnable(key) else {
                    continue
                }
                print("[Env] \(key)=\(value) -> \(result)")
                return result
            }
            print("[Env] \(rawKey) not set -> \(defaultValue)(default)")
            return defaultValue
        } else {
            guard let (value, result) = _envEnable(rawKey) else {
                print("[Env] \(rawKey) not set -> \(defaultValue)(default)")
                return defaultValue
            }
            print("[Env] \(rawKey)=\(value) -> \(result)")
            return result
        }
    }

    func envValue(rawKey: String, default defaultValue: Int, searchInDomain: Bool) -> Int {
        if searchInDomain {
            for domain in domains {
                let key = "\(domain.uppercased())_\(rawKey)"
                guard let (value, result) = _envValue(key) else {
                    continue
                }
                print("[Env] \(key)=\(value) -> \(result)")
                return result
            }
            print("[Env] \(rawKey) not set -> \(defaultValue)(default)")
            return defaultValue
        } else {
            guard let (value, result) = _envValue(rawKey) else {
                print("[Env] \(rawKey) not set -> \(defaultValue)(default)")
                return defaultValue
            }
            print("[Env] \(rawKey)=\(value) -> \(result)")
            return result
        }
    }

    private func _envEnable(_ key: String) -> (String, Bool)? {
        guard let value = Context.environment[key] else {
            return nil
        }
        let result: Bool
        if value == "1" {
            result = true
        } else if value == "0" {
            result = false
        } else {
            return nil
        }
        return (value, result)
    }

    private func _envValue(_ key: String) -> (String, Int)? {
        guard let value = Context.environment[key] else {
            return nil
        }
        let result: Int
        guard let result = Int(value) else {
            return nil
        }
        return (value, result)
    }
}
EnvManager.shared.register(domain: "OpenAttributeGraph")
EnvManager.shared.register(domain: "OpenSwiftUI")

@MainActor
func envEnable(_ key: String, default defaultValue: Bool = false, searchInDomain: Bool = true) -> Bool {
    EnvManager.shared.envEnable(rawKey: key, default: defaultValue, searchInDomain: searchInDomain)
}

@MainActor
func envValue(_ key: String, default defaultValue: Int, searchInDomain: Bool = true) -> Int {
    EnvManager.shared.envValue(rawKey: key, default: defaultValue, searchInDomain: searchInDomain)
}

#if os(macOS)
// NOTE: #if os(macOS) check is not accurate if we are cross compiling for Linux platform. So we add an env key to specify it.
let buildForDarwinPlatform = envEnable("BUILD_FOR_DARWIN_PLATFORM", default: true)
#else
let buildForDarwinPlatform = envEnable("BUILD_FOR_DARWIN_PLATFORM")
#endif


// https://github.com/SwiftPackageIndex/SwiftPackageIndex-Server/issues/3061#issuecomment-2118821061
// By-pass https://github.com/swiftlang/swift-package-manager/issues/7580
let isSPIDocGenerationBuild = envEnable("SPI_GENERATE_DOCS", default: false)
let isSPIBuild = envEnable("SPI_BUILD")

// MARK: - Env and Config

let isXcodeEnv = Context.environment["__CFBundleIdentifier"] == "com.apple.dt.Xcode"
let development = envEnable("DEVELOPMENT", default: false)

// From Swift toolchain being installed or from Swift SDK.
func detectLibSwiftPath() -> String {
    guard let libSwiftPath = Context.environment["OPENATTRIBUTEGRAPH_LIB_SWIFT_PATH"] else {
        // Fallback when LIB_SWIFT_PATH is not set
        let swiftBinPath = Context.environment["OPENATTRIBUTEGRAPH_BIN_SWIFT_PATH"] ?? Context.environment["_"] ?? "/usr/bin/swift"
        let swiftBinURL = URL(fileURLWithPath: swiftBinPath)
        let SDKPath = swiftBinURL.deletingLastPathComponent().deletingLastPathComponent().deletingLastPathComponent().path
        return SDKPath.appending("/usr/lib/swift")
    }
    return libSwiftPath
}
let libSwiftPath = detectLibSwiftPath()

var sharedCSettings: [CSetting] = [
    .unsafeFlags(["-I", libSwiftPath], .when(platforms: .nonDarwinPlatforms)),
    .define("NDEBUG", .when(configuration: .release)),
]

var sharedSwiftSettings: [SwiftSetting] = [
    .enableUpcomingFeature("InternalImportsByDefault"),
    .enableExperimentalFeature("Extern"),
    .swiftLanguageMode(.v5),
]

// MARK: [env] OPENATTRIBUTEGRAPH_SWIFT_TOOLCHAIN_PATH

// Modified from: https://github.com/swiftlang/swift/blob/main/SwiftCompilerSources/Package.swift
//
// Create a couple of symlinks to an existing Ninja build:
//
//     ```shell
//     cd $OPENATTRIBUTEGRAPH_SWIFT_TOOLCHAIN_PATH
//     mkdir -p build/Default
//     ln -s build/<Ninja-Build>/llvm-<os+arch> build/Default/llvm
//     ln -s build/<Ninja-Build>/swift-<os+arch> build/Default/swift
//     ```
//
// where <$OPENATTRIBUTEGRAPH_SWIFT_TOOLCHAIN_PATH> is the parent directory of the swift repository.

let swiftToolchainPath = Context.environment["OPENATTRIBUTEGRAPH_SWIFT_TOOLCHAIN_PATH"] ?? (development ? "/Volumes/BuildMachine/swift-project" : "")
if !swiftToolchainPath.isEmpty {
    sharedCSettings.append(
        .unsafeFlags(
            [
                "-static",
                "-DCOMPILED_WITH_SWIFT",
                "-DPURE_BRIDGING_MODE",
                "-UIBOutlet", "-UIBAction", "-UIBInspectable",
                "-I\(swiftToolchainPath)/swift/include",
                "-I\(swiftToolchainPath)/swift/stdlib/public/SwiftShims",
                "-I\(swiftToolchainPath)/llvm-project/llvm/include",
                "-I\(swiftToolchainPath)/llvm-project/clang/include",
                "-I\(swiftToolchainPath)/build/Default/swift/include",
                "-I\(swiftToolchainPath)/build/Default/llvm/include",
                "-I\(swiftToolchainPath)/build/Default/llvm/tools/clang/include",
                "-DLLVM_DISABLE_ABI_BREAKING_CHECKS_ENFORCING", // Required to fix LLVM link issue
            ]
        )
    )
}

// MARK: [env] OPENATTRIBUTEGRAPH_SWIFT_TOOLCHAIN_VERSION

let swiftToolchainVersion = Context.environment["OPENATTRIBUTEGRAPH_SWIFT_TOOLCHAIN_VERSION"] ?? (development ? "6.0.2" : "")
if !swiftToolchainVersion.isEmpty {
    sharedCSettings.append(
        .define("OPENATTRIBUTEGRAPH_SWIFT_TOOLCHAIN_VERSION", to: swiftToolchainVersion)
    )
}

// MARK: - [env] OPENATTRIBUTEGRAPH_SWIFT_TOOLCHAIN_SUPPORTED

let swiftToolchainSupported = envEnable("SWIFT_TOOLCHAIN_SUPPORTED", default: !swiftToolchainVersion.isEmpty)
if swiftToolchainSupported {
    sharedCSettings.append(.define("OPENATTRIBUTEGRAPH_SWIFT_TOOLCHAIN_SUPPORTED"))
    sharedSwiftSettings.append(.define("OPENATTRIBUTEGRAPH_SWIFT_TOOLCHAIN_SUPPORTED"))
}

// MARK: - [env] OPENATTRIBUTEGRAPH_TARGET_RELEASE

let releaseVersion = Context.environment["OPENATTRIBUTEGRAPH_TARGET_RELEASE"].flatMap { Int($0) } ?? 2024
//sharedCSettings.append(.define("OPENATTRIBUTEGRAPH_RELEASE", to: "\(releaseVersion)"))
sharedSwiftSettings.append(.define("OPENATTRIBUTEGRAPH_RELEASE_\(releaseVersion)"))
if releaseVersion >= 2021 {
    for year in 2021 ... releaseVersion {
        sharedSwiftSettings.append(.define("OPENATTRIBUTEGRAPH_SUPPORT_\(year)_API"))
    }
}

// MARK: - [env] OPENATTRIBUTEGRAPH_WERROR

let warningsAsErrorsCondition = envEnable("WERROR", default: isXcodeEnv && development)
if warningsAsErrorsCondition {
    sharedSwiftSettings.append(.unsafeFlags(["-warnings-as-errors"]))
}

// MARK: - [env] OPENATTRIBUTEGRAPH_LIBRARY_EVOLUTION

let libraryEvolutionCondition = envEnable("LIBRARY_EVOLUTION", default: buildForDarwinPlatform)

if libraryEvolutionCondition {
    // NOTE: -enable-library-evolution will cause module verify failure for `swift build`.
    // Either set OPENATTRIBUTEGRAPH_LIBRARY_EVOLUTION=0 or add `-Xswiftc -no-verify-emitted-module-interface` after `swift build`
    sharedSwiftSettings.append(.unsafeFlags(["-enable-library-evolution", "-no-verify-emitted-module-interface"]))
}

// MARK: - [env] OPENATTRIBUTEGRAPH_COMPATIBILITY_TEST

let compatibilityTestCondition = envEnable("COMPATIBILITY_TEST", default: false)
sharedCSettings.append(.define("OPENATTRIBUTEGRAPH", to: compatibilityTestCondition ? "1" : "0"))
if !compatibilityTestCondition {
    sharedSwiftSettings.append(.define("OPENATTRIBUTEGRAPH"))
}

// MARK: - Targets

let openAttributeGraphTarget = Target.target(
    name: "OpenAttributeGraph",
    dependencies: ["OpenAttributeGraphCxx"],
    cSettings: sharedCSettings,
    swiftSettings: sharedSwiftSettings
)
// FIXME: Merge into one target
// OpenAttributeGraph is a C++ & Swift mix target.
// The SwiftPM support for such usage is still in progress.
let openAttributeGraphSPITarget = Target.target(
    name: "OpenAttributeGraphCxx",
    cSettings: sharedCSettings + [
        .define("__COREFOUNDATION_FORSWIFTFOUNDATIONONLY__", to: "1", .when(platforms: .nonDarwinPlatforms)),
    ],
    linkerSettings: [
        .linkedLibrary("z"),
    ]
)
let openAttributeGraphShimsTarget = Target.target(
    name: "OpenAttributeGraphShims",
    cSettings: sharedCSettings,
    swiftSettings: sharedSwiftSettings
)

// MARK: - Test Targets

let openAttributeGraphTestsTarget = Target.testTarget(
    name: "OpenAttributeGraphTests",
    dependencies: [
        "OpenAttributeGraph",
    ],
    exclude: ["README.md"],
    cSettings: sharedCSettings,
    swiftSettings: sharedSwiftSettings
)
let openAttributeGraphCxxTestsTarget = Target.testTarget(
    name: "OpenAttributeGraphCxxTests",
    dependencies: [
        "OpenAttributeGraphCxx",
    ],
    exclude: ["README.md"],
    cSettings: sharedCSettings + [.define("SWIFT_TESTING")],
    swiftSettings: sharedSwiftSettings + [.interoperabilityMode(.Cxx)]
)
let openAttributeGraphShimsTestsTarget = Target.testTarget(
    name: "OpenAttributeGraphShimsTests",
    dependencies: [
        "OpenAttributeGraphShims",
    ],
    exclude: ["README.md"],
    cSettings: sharedCSettings,
    swiftSettings: sharedSwiftSettings
)
let openAttributeGraphCompatibilityTestsTarget = Target.testTarget(
    name: "OpenAttributeGraphCompatibilityTests",
    dependencies: [
        .product(name: "Numerics", package: "swift-numerics"),
    ] + (compatibilityTestCondition ? [] : ["OpenAttributeGraph"]),
    exclude: ["README.md"],
    cSettings: sharedCSettings,
    swiftSettings: sharedSwiftSettings
)

// MARK: - Package

let package = Package(
    name: "OpenAttributeGraph",
    products: [
        .library(name: "OpenAttributeGraph", type: .dynamic, targets: ["OpenAttributeGraph", "OpenAttributeGraphCxx"]),
        .library(name: "OpenAttributeGraphShims", type: .dynamic, targets: ["OpenAttributeGraph", "OpenAttributeGraphCxx", "OpenAttributeGraphShims"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-numerics", from: "1.0.2"),
    ],
    targets: [
        openAttributeGraphTarget,
        openAttributeGraphSPITarget,
        openAttributeGraphShimsTarget,
    ],
    cxxLanguageStandard: .cxx20
)

extension Target {
    func addAGSettings() {
        dependencies.append(
            .product(name: "AttributeGraph", package: "DarwinPrivateFrameworks")
        )
        var swiftSettings = swiftSettings ?? []
        swiftSettings.append(.define("OPENATTRIBUTEGRAPH_ATTRIBUTEGRAPH"))
        self.swiftSettings = swiftSettings
    }
}

if !compatibilityTestCondition {
    package.targets += [
        openAttributeGraphTestsTarget,
        openAttributeGraphCxxTestsTarget,
        openAttributeGraphShimsTestsTarget,
    ]
} else {
    openAttributeGraphCompatibilityTestsTarget.addAGSettings()
}

if buildForDarwinPlatform {
    package.targets.append(openAttributeGraphCompatibilityTestsTarget)
}

let useLocalDeps = envEnable("USE_LOCAL_DEPS")

let attributeGraphCondition = envEnable("ATTRIBUTEGRAPH", default: buildForDarwinPlatform && !isSPIBuild)

if attributeGraphCondition {
    let privateFrameworkRepo: Package.Dependency
    if useLocalDeps {
        privateFrameworkRepo = Package.Dependency.package(path: "../DarwinPrivateFrameworks")
    } else {
        privateFrameworkRepo = Package.Dependency.package(url: "https://github.com/OpenSwiftUIProject/DarwinPrivateFrameworks.git", branch: "main")
    }
    package.dependencies.append(privateFrameworkRepo)
    openAttributeGraphShimsTarget.addAGSettings()
    
    let agVersion = Context.environment["DARWIN_PRIVATE_FRAMEWORKS_TARGET_RELEASE"].flatMap { Int($0) } ?? 2024
    package.platforms = switch agVersion {
        case 2024: [.iOS(.v18), .macOS(.v15), .macCatalyst(.v18), .tvOS(.v18), .watchOS(.v10), .visionOS(.v2)]
        case 2021: [.iOS(.v15), .macOS(.v12), .macCatalyst(.v15), .tvOS(.v15), .watchOS(.v7)]
        default: nil
    }
} else {
    openAttributeGraphShimsTarget.dependencies.append("OpenAttributeGraph")
    package.platforms = [.iOS(.v13), .macOS(.v10_15), .macCatalyst(.v13), .tvOS(.v13), .watchOS(.v5)]
}


extension [Platform] {
    static var nonDarwinPlatforms: [Platform] {
        [.linux, .android, .wasi, .openbsd, .windows]
    }
}
