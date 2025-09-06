# ``Attribute``

A reactive property wrapper that automatically tracks dependencies and manages value updates.

## Overview

`Attribute` is the core building block of the OpenAttributeGraph reactive system. When you wrap a property with `@Attribute`, it becomes reactive and can automatically track dependencies and propagate changes.

    @Attribute var count: Int = 0
    @Attribute var doubledCount: Int = count * 2
    
    count = 5 // doubledCount automatically becomes 10

## Key Features

- Automatic dependency tracking: Attributes automatically discover their dependencies
- Efficient updates: Only affected attributes are recomputed when changes occur
- Type safety: Full Swift type safety with compile-time checking
- Dynamic member lookup: Access nested properties as reactive attributes
- Property wrapper syntax: Clean, declarative syntax using `@Attribute`

## Property Wrapper Usage

Use `@Attribute` to make any Swift value reactive:

    struct CounterView {
        @Attribute var count: Int = 0
        
        var body: some View {
            Button("Count: \(count)") {
                count += 1
            }
        }
    }

## Dynamic Member Lookup

Access nested properties as separate attributes:

    @Attribute var person: Person = Person(name: "Alice", age: 30)
    let nameAttribute: Attribute<String> = person.name
    let ageAttribute: Attribute<Int> = person.age

## Integration with Rules

Create computed attributes using ``Rule`` or ``StatefulRule``:

    struct DoubledRule: Rule {
        typealias Value = Int
        let source: Attribute<Int>
        
        func value() -> Int {
            source.wrappedValue * 2
        }
    }

    let doubled = Attribute(DoubledRule(source: count))

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