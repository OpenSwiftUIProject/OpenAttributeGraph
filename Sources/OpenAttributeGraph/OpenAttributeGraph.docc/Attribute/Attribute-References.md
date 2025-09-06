# Attribute References

Type-erased and reference management for attributes.

## Overview

Attribute references provide type-erased access to attributes and specialized reference management for memory-sensitive scenarios. The AnyAttribute type allows working with attributes without knowing their specific value types, while reference-based attributes provide different memory management strategies.

These reference types are essential for building flexible reactive systems where attribute types may not be known at compile time, or where careful memory management is required to avoid retain cycles.

## Topics

### Type-Erased References

- ``AnyAttribute``

### Reference Creation

- ``AnyAttribute/init(_:)``
- ``Attribute/init(identifier:)``

### Reference Operations

- ``AnyAttribute/unsafeCast(to:)``
- ``Attribute/unsafeCast(to:)``
- ``AnyAttribute/create(offset:size:)``

### Reference Properties

- ``AnyAttribute/identifier``
- ``Attribute/identifier``

### Memory Management

- ``AnyAttribute/graph``
- ``AnyAttribute/subgraph``
- ``Attribute/graph``
- ``Attribute/subgraph``

### Value State

- ``AnyAttribute/valueState``
- ``Attribute/valueState``
- ``AnyAttribute/hasValue``
- ``Attribute/hasValue``