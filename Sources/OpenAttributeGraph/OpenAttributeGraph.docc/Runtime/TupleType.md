# ``TupleType``

Runtime support for Swift tuple types with dynamic element access and memory management.

## Overview

`TupleType` provides runtime introspection and manipulation capabilities for Swift tuple types. It enables dynamic access to tuple elements, memory layout information, and safe element copying operations without requiring compile-time knowledge of the tuple's structure.

    let tupleType = TupleType([Int.self, String.self, Bool.self])
    let tuple = (42, "Hello", true)
    
    // Access elements dynamically
    let intValue: Int = tuple[0]
    let stringValue: String = tuple[1]
    let boolValue: Bool = tuple[2]

TupleType is essential for OpenAttributeGraph's ability to work with heterogeneous data structures while maintaining type safety and efficient memory operations.

## Key Features

- Dynamic tuple creation: Create tuple types from arrays of Swift types
- Element access: Safely access tuple elements by index with type checking  
- Memory management: Initialize, copy, and destroy tuple elements safely
- Layout introspection: Query element offsets, sizes, and memory layout
- Buffer operations: Work with raw memory buffers containing tuple data

## Usage with Attributes

TupleType enables OpenAttributeGraph to create attributes that contain heterogeneous data structures, supporting complex reactive computations over tuple-based data.

## Topics

### Creating Tuple Types

- ``init(_:)``
- ``init(_:)-9jmk1``
- ``init(count:elements:)``

### Type Properties

- ``type``
- ``count``
- ``size``
- ``isEmpty``
- ``indices``

### Element Access

- ``type(at:)``
- ``elementType(at:)``
- ``elementSize(at:)``
- ``elementOffset(at:type:)``
- ``offset(at:as:)``

### Element Operations

- ``setElement(in:at:from:options:)``
- ``getElement(in:at:to:options:)``
- ``destroy(_:)``
- ``destroy(_:at:)``

### Copy Options

- ``CopyOptions``

### Buffer Functions

- ``withUnsafeTuple(of:count:_:)``