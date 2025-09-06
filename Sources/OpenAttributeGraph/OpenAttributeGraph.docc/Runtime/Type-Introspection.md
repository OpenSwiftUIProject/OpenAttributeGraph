# Type Introspection

Runtime type information and introspection utilities.

## Overview

Type introspection provides runtime access to Swift type metadata, enabling OpenAttributeGraph to work with types dynamically.

## Topics

### Type Metadata

- ``Metadata``

### Metadata Creation

- ``Metadata/init(_:)``

### Type Properties

- ``Metadata/description``

### Runtime Utilities

- ``MemoryLayout/offset(of:)``
- ``PointerOffset``

### Memory Layout

- ``PointerOffset/offset(_:)``
- ``PointerOffset/byteOffset``
- ``Attribute/unsafeOffset(at:as:)``
- ``Attribute/applying(offset:)``

### Type Validation

- ``Attribute/validate()``
- ``AnyAttribute/verify(type:)``
