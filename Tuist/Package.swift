// swift-tools-version: 6.3
import PackageDescription

let environment = Context.environment
let useComputeBackend = environment["OPENATTRIBUTEGRAPH_OPENATTRIBUTESHIMS_COMPUTE"] == "1"
let useComputeBinary = environment["OPENATTRIBUTEGRAPH_OPENATTRIBUTESHIMS_COMPUTE_BINARY"] == "1"

#if TUIST
import ProjectDescription

var packageProductTypes: [String: ProjectDescription.Product] = [:]
if useComputeBackend && !useComputeBinary {
    packageProductTypes["Compute"] = .staticFramework
}

let packageSettings = PackageSettings(
    productTypes: packageProductTypes
)
#endif

var dependencies: [PackageDescription.Package.Dependency] = [
    .package(url: "https://github.com/apple/swift-numerics", from: "1.1.1"),
]
var targets: [PackageDescription.Target] = []

if useComputeBackend {
    if useComputeBinary {
        let version = environment["OPENATTRIBUTEGRAPH_OPENATTRIBUTESHIMS_COMPUTE_BINARY_VERSION"] ?? "0.5.2"
        let repository = environment["OPENATTRIBUTEGRAPH_OPENATTRIBUTESHIMS_COMPUTE_BINARY_REPO"] ?? "jcmosc/Compute"
        let url = environment["OPENATTRIBUTEGRAPH_OPENATTRIBUTESHIMS_COMPUTE_BINARY_URL"]
            ?? "https://github.com/\(repository)/releases/download/\(version)/Compute.xcframework.zip"
        let checksum = environment["OPENATTRIBUTEGRAPH_OPENATTRIBUTESHIMS_COMPUTE_BINARY_CHECKSUM"]
            ?? "0eca53a3620776cffcc3d2047d11efaf893b53078b95e59e793f86caa3f2c169"
        targets.append(
            .binaryTarget(
                name: "Compute",
                url: url,
                checksum: checksum
            )
        )
    } else {
        let repository = environment["OPENATTRIBUTEGRAPH_OPENATTRIBUTESHIMS_COMPUTE_SOURCE_REPO"]
            ?? "OpenSwiftUIProject/Compute"
        let version = environment["OPENATTRIBUTEGRAPH_OPENATTRIBUTESHIMS_COMPUTE_SOURCE_VERSION"] ?? "0.5.2"
        if let branch = environment["OPENATTRIBUTEGRAPH_OPENATTRIBUTESHIMS_COMPUTE_SOURCE_BRANCH"] {
            dependencies.append(
                .package(url: "https://github.com/\(repository)", branch: branch)
            )
        } else {
            dependencies.append(
                .package(url: "https://github.com/\(repository)", exact: .init(stringLiteral: version))
            )
        }
    }
}

let package = PackageDescription.Package(
    name: "OpenAttributeGraphDeps",
    dependencies: dependencies,
    targets: targets
)
