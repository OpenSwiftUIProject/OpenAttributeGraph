## SwiftBridging

Cross-platform Swift/C++ bridging compatibility header, solving the `<swift/bridging>` availability issue on non-Darwin Swift toolchains.

Based on [WebKit's SwiftBridging.h approach](https://github.com/WebKit/WebKit/blob/84fc0edf9e8649a56cca35cc48c73f211e310d14/Source/WTF/wtf/SwiftBridging.h).

On toolchains where `<swift/bridging>` is available, it includes the system header and provides fallback definitions for newer attributes. On toolchains without it, all bridging macros are defined as no-ops for compatibility.
