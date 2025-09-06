# Type Introspection

Runtime type information and introspection utilities.

## Overview

Type introspection provides runtime access to Swift type metadata, enabling OpenAttributeGraph to work with types dynamically. The Metadata system allows the framework to handle type information at runtime, supporting features like type-erased attributes and dynamic type checking.

TupleType provides specialized support for working with tuple types at runtime, enabling dynamic element access and memory management for heterogeneous data structures.

## Topics

### Type Metadata

- ``Metadata``
- ``TupleType``

### Metadata Creation

- ``Metadata/init(_:)``
- ``TupleType/init(_:)``
- ``TupleType/init(_:)-9jmk1``
- ``TupleType/init(count:elements:)``

### Type Properties

- ``Metadata/description``
- ``TupleType/type``
- ``TupleType/count``
- ``TupleType/size``

### Tuple Operations

- ``UnsafeTuple``
- ``UnsafeMutableTuple``
- ``withUnsafeTuple(of:count:_:)``

### Runtime Utilities

- ``MemoryLayout/offset(of:)``
- ``PointerOffset``

### Memory Layout

- ``PointerOffset/offset(_:)``
- ``PointerOffset/byteOffset``
- ``Attribute/unsafeOffset(at:as:)``
- ``Attribute/applying(offset:)``
- ``TupleType/elementOffset(at:type:)``

### Type Validation

- ``Attribute/validate()``
- ``AnyAttribute/verify(type:)``
