# OpenAttributeGraph

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FOpenSwiftUIProject%2FOpenAttributeGraph%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/OpenSwiftUIProject/OpenAttributeGraph)

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FOpenSwiftUIProject%2FOpenAttributeGraph%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/OpenSwiftUIProject/OpenAttributeGraph)

[![codecov](https://codecov.io/gh/OpenSwiftUIProject/OpenAttributeGraph/graph/badge.svg?token=W1KDSUMWJW)](https://codecov.io/gh/OpenSwiftUIProject/OpenAttributeGraph)

OpenAttributeGraph is an open source implementation of Apple's Private framework - AttributeGraph

AttributeGraph is a high performance computing engine written in C++ and Swift.

And it powers the underlying computing and diffing of SwiftUI.

## Architecture

OpenAttributeGraph consists of three main components:

### Attribute Part
The **Attribute** system provides a reactive property wrapper that automatically tracks dependencies and manages value updates. Key features include:
- `Attribute<Value>` - A property wrapper for reactive values with automatic dependency tracking
- `AnyAttribute` - Type-erased attribute for runtime flexibility  
- **Rules** - Transform attributes through `Rule` and `StatefulRule` protocols
- **Weak/Optional** - Support for optional and weak attribute references
- **Body system** - Efficient value computation and caching mechanisms

### Graph Part
The **Graph** manages the dependency network and orchestrates updates across attributes. Core functionality includes:
- `Graph` - Central coordinator for attribute relationships and update cycles
- `Subgraph` - Scoped computation contexts for isolated attribute groups
- **Invalidation tracking** - Efficient change propagation through the dependency graph
- **Update scheduling** - Optimized batch processing of attribute changes
- **Profiling support** - Performance monitoring and debugging capabilities

### Runtime Part
The **Runtime** provides low-level type introspection and memory management utilities. This includes:
- `Metadata` - Swift runtime type information and reflection capabilities
- **Type comparison** - Efficient value equality checking across different types  
- **Memory layout** - Safe pointer manipulation and offset calculations
- **Tuple handling** - Runtime support for tuple types and field access

> **Note**: The Runtime part leverages techniques similar to those found in [wickwirew/Runtime](https://github.com/wickwirew/Runtime) for Swift runtime introspection.

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

## Usage

### Via Swift Package Manager

Add OpenAttributeGraph as a dependency in your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/OpenSwiftUIProject/OpenAttributeGraph.git", from: "0.2.0")
]
```

> [!NOTE]
> - You may need to configure the Swift toolchain header for proper integration of OpenAttributeGraph
> - By default, OpenAttributeGraphShims will use the private AttributeGraph as its implementation on Apple platforms

### Via Prebuilt XCFramework

For a simpler setup, you can use the prebuilt XCFramework available on the [releases page](https://github.com/OpenSwiftUIProject/OpenAttributeGraph/releases).

## Build

The current suggested toolchain to build the project is Swift 6.1.2 / Xcode 16.4.

## License

See LICENSE file - MIT

## Credits

See [CREDITS.md](CREDITS.md) for third-party licenses and acknowledgements.
