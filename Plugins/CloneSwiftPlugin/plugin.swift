import Foundation
import PackagePlugin

@main
struct CloneSwiftPlugin: BuildToolPlugin {
    func createBuildCommands(context: PluginContext, target: Target) throws -> [Command] {
        let packageDir = context.package.directoryURL
        let checkoutPath = packageDir.appending(path: ".build/checkouts/swift")
        let script = packageDir.appending(path: "Scripts/clone-swift.sh")

        let env = ProcessInfo.processInfo.environment

        let effectivePath = env["SWIFT_TOOLCHAIN_PATH"] ?? checkoutPath.path()
        var scriptArgs = "\(script.path()) --path \(effectivePath)"

        if let version = env["SWIFT_TOOLCHAIN_VERSION"],
           !version.isEmpty {
            scriptArgs += " --swift-version \(version)"
        }

        return [
            .prebuildCommand(
                displayName: "Clone Swift repository headers",
                executable: URL(filePath: "/bin/zsh"),
                arguments: [
                    "-c",
                    "\(scriptArgs) 2>&1 || echo 'warning: CloneSwiftPlugin: clone-swift.sh failed (sandbox may have blocked it). Run Scripts/clone-swift.sh manually.'",
                ],
                outputFilesDirectory: context.pluginWorkDirectoryURL
            )
        ]
    }
}
