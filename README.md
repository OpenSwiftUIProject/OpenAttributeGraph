# OpenAttributeGraph

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FOpenSwiftUIProject%2FOpenAttributeGraph%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/OpenSwiftUIProject/OpenAttributeGraph)

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FOpenSwiftUIProject%2FOpenAttributeGraph%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/OpenSwiftUIProject/OpenAttributeGraph)

[![codecov](https://codecov.io/gh/OpenSwiftUIProject/OpenAttributeGraph/graph/badge.svg?token=W1KDSUMWJW)](https://codecov.io/gh/OpenSwiftUIProject/OpenAttributeGraph)

OpenAttributeGraph is an open source implementation of Apple's Private framework - AttributeGraph which is a high performance computing engine written in C++ and Swift.

And it powers the underlying computing and diffing of [OpenSwiftUI](https://github.com/OpenSwiftUIProject/OpenSwiftUI).

| **CI Status** |
|---|
|[![Compatibility tests](https://github.com/OpenSwiftUIProject/OpenAttributeGraph/actions/workflows/compatibility_tests.yml/badge.svg)](https://github.com/OpenSwiftUIProject/OpenAttributeGraph/actions/workflows/compatibility_tests.yml)|
|[![macOS](https://github.com/OpenSwiftUIProject/OpenAttributeGraph/actions/workflows/macos.yml/badge.svg)](https://github.com/OpenSwiftUIProject/OpenAttributeGraph/actions/workflows/macos.yml)|
|[![iOS](https://github.com/OpenSwiftUIProject/OpenAttributeGraph/actions/workflows/ios.yml/badge.svg)](https://github.com/OpenSwiftUIProject/OpenAttributeGraph/actions/workflows/ios.yml)|
|[![Ubuntu](https://github.com/OpenSwiftUIProject/OpenAttributeGraph/actions/workflows/ubuntu.yml/badge.svg)](https://github.com/OpenSwiftUIProject/OpenAttributeGraph/actions/workflows/ubuntu.yml)|

The project is for the following purposes:
- Add OAG support for non-Apple platform (eg. Linux, WASI and Windows)
- Diagnose and debug AG issues on Apple platform

Currently, this project is in early development.

Please refer to the [documentation](https://swiftpackageindex.com/OpenSwiftUIProject/OpenAttributeGraph/main/documentation/openattributegraph) for more information on it.

## Usage

### Via Swift Package Manager

Add OpenAttributeGraph as a dependency in your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/OpenSwiftUIProject/OpenAttributeGraph.git", from: "0.2.0")
]
```

> [!NOTE]
>
> - You may need to configure the Swift toolchain header for proper integration of OpenAttributeGraph
> - By default, OpenAttributeGraphShims will use the private AttributeGraph as its implementation on Apple platforms

### Via Prebuilt XCFramework

For a simpler setup, you can use the prebuilt XCFramework available on the [releases page](https://github.com/OpenSwiftUIProject/OpenAttributeGraph/releases).

## Project Structure

| Target | Description |
|--------|-------------|
| **OpenAttributeGraph** | Main Swift module exposing the public API |
| **OpenAttributeGraphCxx** | Core C++ engine implementation |
| **OpenAttributeGraphShims** | Compatibility shims (uses OAG/AG implementation according to macro definition) |
| **Utilities** | Low-level C++ data structures and smart pointers (Heap, HashTable, ForwardList, cf_ptr) |
| **Platform** | Cross-platform abstraction for logging and memory allocation |
| **SwiftBridging** | Swift/C++ bridging compatibility header |
| **SwiftCorelibsCoreFoundation** | CoreFoundation API headers for non-Darwin platforms |

## Build

The current suggested toolchain to build the project is Swift 6.1.2 / Xcode 16.4.

### Clone Swift headers

The project requires Swift toolchain headers for compilation. You can either clone them manually or let the build plugin handle it:

```shell
# Option 1: Clone headers manually
./Scripts/clone-swift.sh

# Option 2: Let the build plugin clone headers (requires --disable-sandbox)
swift build --disable-sandbox
```

### Set up LIB_SWIFT_PATH on non-Darwin platform

If your swift binary path is located in your `<toolchain>/usr/bin/swift` (eg. installed by [swiftbox](https://github.com/stevapple/swiftbox)), no setup is required.

Otherwise set up it manully by exporting `LIB_SWIFT_PATH` environment variable.

> The following command assume you already have [swiftly](https://github.com/swiftlang/swiftly) installed.

```shell
export OPENATTRIBUTEGRAPH_LIB_SWIFT_PATH="$(swiftly use --print-location)/usr/lib/swift"
# Or use the swift_static path
export OPENATTRIBUTEGRAPH_LIB_SWIFT_PATH="$(swiftly use --print-location)/usr/lib/swift_static"
```

Alternatively, you can set the path using the Swift SDK location. For example:

```shell
export OPENATTRIBUTEGRAPH_LIB_SWIFT_PATH=~/.swiftpm/swift-sdks/swift-6.1.3-RELEASE_static-linux-0.0.1.artifactbundle/swift-6.1.3-RELEASE_static-linux-0.0.1/swift-linux-musl/musl-1.2.5.sdk/aarch64/usr/lib/swift_static
```

## License

See LICENSE file - MIT

## Credits

See [CREDITS.md](CREDITS.md) for third-party licenses and acknowledgements.
