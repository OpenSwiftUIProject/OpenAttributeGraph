# ``Metadata``

Swift runtime type information and reflection capabilities for OpenAttributeGraph.

## Overview

`Metadata` provides access to Swift's runtime type system, enabling type introspection and dynamic operations that power OpenAttributeGraph's reactive system.

    let intMetadata = Metadata(Int.self)
    let stringMetadata = Metadata(String.self)
    
    let metadata = Metadata(String.self)
    let type = metadata.type // Returns String.Type

## Key Features

- Runtime type introspection: Access Swift type metadata at runtime
- Field enumeration: Discover the fields of any Swift type
- Type comparison: Efficient equality checking across different types
- Memory layout: Access memory layout and alignment details

## Usage with Attributes

Metadata enables OpenAttributeGraph to perform type-safe operations on attributes with different value types, supporting features like automatic KeyPath-based attribute access and efficient value comparison.

## Topics

### Creating Metadata

- ``init(_:)``

### Type Information

- ``type``
- ``description``

### Field Introspection

- ``forEachField(options:do:)``

### Global Functions

- ``forEachField(of:do:)``