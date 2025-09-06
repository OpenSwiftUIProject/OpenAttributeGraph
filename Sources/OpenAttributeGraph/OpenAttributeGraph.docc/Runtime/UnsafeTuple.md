# ``UnsafeTuple``

Immutable tuple buffer for safe element access and type-checked operations.

## Overview

`UnsafeTuple` provides safe, type-checked access to elements within a tuple stored in a raw memory buffer. It combines tuple type metadata with a pointer to tuple data, enabling runtime inspection and element retrieval while maintaining memory safety.

    withUnsafeTuple(of: tupleType, count: 1) { unsafeTuple in
        let firstElement: Int = unsafeTuple[0]
        let secondElement: String = unsafeTuple[1]
        // Access elements safely with compile-time type checking
    }

## Key Features

- Type-safe element access: Access tuple elements with automatic type verification
- Index-based operations: Use integer indices to access elements by position  
- Memory safety: Bounds checking and type validation prevent unsafe memory access
- Address computation: Get typed pointers to specific tuple elements

## Topics

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