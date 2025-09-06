# ``UnsafeMutableTuple``

Mutable tuple buffer for dynamic tuple creation, modification, and memory management.

## Overview

`UnsafeMutableTuple` extends `UnsafeTuple` with mutation capabilities, allowing creation, modification, and destruction of tuple data. It provides complete lifecycle management for dynamically created tuples with proper memory allocation and cleanup.

    let mutableTuple = UnsafeMutableTuple(with: tupleType)
    
    // Initialize elements
    mutableTuple.initialize(at: 0, to: 42)
    mutableTuple.initialize(at: 1, to: "Hello")
    
    // Access and modify
    mutableTuple[0] = 100
    let value: String = mutableTuple[1]
    
    // Clean up
    mutableTuple.deallocate(initialized: true)

## Key Features

- Dynamic allocation: Create tuple buffers with proper memory alignment
- Element initialization: Initialize tuple elements in-place with type safety
- Mutation operations: Modify tuple elements after creation
- Memory management: Proper cleanup with element-wise deinitialization
- Lifecycle control: Manual control over initialization and deallocation phases

## Topics

### Creating Mutable Tuples

- ``init(with:)``

### Element Initialization

- ``initialize(at:to:)``

### Memory Management

- ``deinitialize()``
- ``deinitialize(at:)``
- ``deallocate(initialized:)``

### Tuple Properties

- ``count``
- ``isEmpty``
- ``indices``

### Element Access

- ``subscript()``
- ``subscript(_:)``

### Address Operations

- ``address(as:)``
- ``address(of:as:)``