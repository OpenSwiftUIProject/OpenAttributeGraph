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

## Build

The current suggested toolchain to build the project is Swift 6.1.2 / Xcode 16.4.

### Usage with ```swiftly````

If you have installed [Swiftly](https://github.com/swiftlang/swiftly) for managing your installed swift toolchains (Linux) set the following variable to your shell:

```bash
export SWIFT_TOOLCHAIN_PATH="$(swiftly use --print-location)"
```

```fish
set -gx SWIFT_TOOLCHAIN_PATH (swiftly use --print-location)
```

Then run `swift build`

## License

See LICENSE file - MIT

## Credits

See [CREDITS.md](CREDITS.md) for third-party licenses and acknowledgements.
