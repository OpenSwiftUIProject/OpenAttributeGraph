# ``Attribute``

## Topics

### Creating Attributes

- ``init(identifier:)``
- ``init(_:)``
- ``init(value:)``
- ``init(type:)``

### Property Wrapper

- ``wrappedValue``
- ``projectedValue``

### Dynamic Member Access

- ``subscript(dynamicMember:)``
- ``subscript(keyPath:)``
- ``subscript(offset:)``

### Type Transformations

- ``unsafeCast(to:)``
- ``unsafeOffset(at:as:)``
- ``applying(offset:)``

### Graph Integration

- ``graph``
- ``subgraph``

### Value Management

- ``value``
- ``valueState``
- ``valueAndFlags(options:)``
- ``changedValue(options:)``
- ``setValue(_:)``
- ``hasValue``
- ``updateValue()``
- ``prefetchValue()``
- ``invalidateValue()``
- ``validate()``

### Input Management

- ``addInput(_:options:token:)-9c3h6``
- ``addInput(_:options:token:)-7u9k3``

### Flags and State

- ``Flags``
- ``flags``
- ``setFlags(_:mask:)``

### Advanced Operations

- ``visitBody(_:)``
- ``mutateBody(as:invalidating:_:)``
- ``breadthFirstSearch(options:_:)``