## UtilitiesTests

Test C++ API of Utilities via Swift C++ interop.

### Why `@available(iOS 16.4, *)`

Every test function requires `@available(iOS 16.4, *)` because the Swift runtime support for C++ interop (eg. correct metadata initialization for foreign reference types) is only available since iOS 16.4.

See https://github.com/swiftlang/swift/issues/72827 for an example of such runtime issue.

### References

- [Importing C++ into Swift](https://www.swift.org/documentation/cxx-interop/#importing-c-into-swift)
