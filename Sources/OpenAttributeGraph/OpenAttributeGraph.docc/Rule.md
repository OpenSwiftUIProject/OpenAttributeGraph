# ``Rule``

A protocol for defining computed attributes that automatically update when dependencies change.

## Overview

Rules provide a way to create derived attributes that compute their values based on other attributes. When any dependency changes, the rule will automatically recompute its value.

    struct DoubledRule: Rule {
        typealias Value = Int
        let source: Attribute<Int>
        
        var value: Int {
            source.wrappedValue * 2
        }
    }

    @Attribute var count: Int = 5
    let doubled = Attribute(DoubledRule(source: $count))
    // doubled.wrappedValue == 10

    count = 10
    // doubled.wrappedValue automatically becomes 20

## Key Features

- Automatic dependency tracking: Dependencies are discovered automatically when accessed
- Lazy evaluation: Values are only computed when needed
- Caching: Results are cached until dependencies change
- Efficient updates: Only recomputes when dependencies actually change

## Implementation Requirements

Types conforming to `Rule` must provide:
- `Value`: The type of value produced by the rule
- `value`: A computed property that returns the current value
- `initialValue`: An optional initial value (defaults to `nil`)

## Advanced Usage

For rules that need to maintain state between evaluations, see ``StatefulRule``.
For rules that can be cached based on their content, make your rule type conform to `Hashable`.

## Topics

### Protocol Requirements

- ``Value``
- ``initialValue``
- ``value``

### Context Access

- ``attribute``
- ``context``

### Cached Evaluation

- ``cachedValue(options:owner:)``
- ``cachedValueIfExists(options:owner:)``