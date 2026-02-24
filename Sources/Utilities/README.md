## Utilities

Low-level C++ utility data structures and smart pointers for OpenAttributeGraph, based on [Compute](https://github.com/OpenSwiftUIProject/Compute)'s Utilities module.

### Contents

- **Heap** - Custom memory allocator with configurable increment size and node-based allocation
- **HashTable** - Untyped and typed hash table with bucket management and automatic growth
- **ForwardList** - Singly-linked list using Heap for allocation with spare node reuse
- **cf_ptr** - RAII wrapper for CoreFoundation objects (uses SwiftCorelibsCoreFoundation on non-Darwin platforms)
- **objc_ptr** - RAII wrapper for Objective-C objects (Darwin only)
- **Base** - Foundational macros for nullability, compiler attributes, and Swift bridging
