# ``OptionalAttribute``

An optional attribute wrapper that may or may not contain a value.

## Overview

`OptionalAttribute` provides a way to work with attributes that may be nil, offering optional semantics for attribute references. This is useful when working with attributes that may be conditionally created or destroyed.

    @OptionalAttribute var maybeAttribute: Int?
    
    if let value = maybeAttribute {
        print("Attribute value: \(value)")
    }

The optional attribute wrapper automatically handles the optional nature of attribute references while maintaining the reactive capabilities of the attribute system.

## Key Features

- Optional semantics: Natural handling of attributes that may not exist
- Conditional access: Safe access to potentially nil attributes
- Reactive updates: Changes propagate when the attribute becomes available
- Integration with weak attributes: Works seamlessly with ``WeakAttribute``

## Usage Pattern

OptionalAttribute is commonly used for:
- Conditionally created UI elements
- Optional data model properties
- Weak attribute references that may become nil
- Lazy initialization scenarios

## Topics

### Creating Optional Attributes

- ``init()``
- ``init(base:)``
- ``init(_:)-47ane``
- ``init(_:)-9eqjv``
- ``init(_:)-2u3gq``

### Property Wrapper

- ``wrappedValue``
- ``projectedValue``

### Value Access

- ``attribute``
- ``value``
- ``changedValue(options:)``

### Transformations

- ``map(_:)``

### Base Access

- ``base``