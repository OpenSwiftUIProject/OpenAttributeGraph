# ``WeakAttribute``

A weak reference property wrapper for attributes that prevents retain cycles.

## Overview

`WeakAttribute` provides a way to hold weak references to attributes, preventing strong reference cycles in the attribute graph while still allowing access to reactive values.

    @WeakAttribute var parentAttribute: SomeType?
    
    // Safe access to potentially deallocated attribute
    if let value = parentAttribute {
        print("Parent value: \(value)")
    }

The weak attribute automatically becomes `nil` when the referenced attribute is deallocated, providing memory-safe access to optional attribute references.

## Key Features

- Weak references: Prevents retain cycles in attribute relationships
- Automatic nil assignment: Referenced attributes become nil when deallocated  
- Dynamic member lookup: Access nested properties through weak references
- Optional semantics: All values are optional since references may be deallocated

## Usage Pattern

WeakAttribute is essential for:
- Parent-child attribute relationships
- Observer patterns that don't own the observed attribute
- Breaking potential retain cycles in complex attribute graphs
- Optional attribute references in data structures

## Topics

### Creating Weak Attributes

- ``init()``
- ``init(base:)``
- ``init(_:)-4u8wa``
- ``init(_:)-571kb``

### Property Wrapper

- ``wrappedValue``
- ``projectedValue``

### Dynamic Member Access

- ``subscript(dynamicMember:)``

### Value Access

- ``attribute``
- ``value``
- ``changedValue(options:)``