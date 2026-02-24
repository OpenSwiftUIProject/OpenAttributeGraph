## SwiftCorelibsCoreFoundation

CoreFoundation API compatibility headers for non-Darwin platforms, sourced from the [Swift project](https://github.com/swiftlang/swift-corelibs-foundation).

This module provides the subset of CoreFoundation types (CFBase, CFArray, CFDictionary, CFString, etc.) needed by OpenAttributeGraph on platforms where Apple's CoreFoundation is not available.

Only used on non-Darwin platforms (Linux, WASI, Windows).
