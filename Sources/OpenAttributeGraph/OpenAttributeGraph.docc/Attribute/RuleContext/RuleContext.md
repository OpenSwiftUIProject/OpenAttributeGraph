# ``RuleContext``

Context object providing access to rule evaluation state and input values.

## Overview

`RuleContext` provides a structured way to access input values and manage state during rule evaluation. It offers type-safe access to dependent attributes and their values within the context of a specific rule execution.

The context ensures that dependency tracking is properly maintained while providing convenient access to input attributes.

## Key Features

- Type-safe input access: Access dependent attribute values with full type safety
- Dependency tracking: Automatically tracks accessed attributes as dependencies
- Value management: Direct access to current and changed values
- Context isolation: Maintains evaluation context for proper dependency resolution

## Usage in Rules

RuleContext is typically used within ``StatefulRule`` implementations to access dependencies and manage the rule's output value:

    struct MyRule: StatefulRule {
        let inputAttribute: Attribute<Int>
        
        mutating func updateValue() {
            let inputValue = context[inputAttribute]
            value = inputValue * 2
        }
    }

## Topics

### Creating Context

- ``init(attribute:)``

### Input Access

- ``subscript(_:)-1g3wa``
- ``subscript(_:)-6y4wa``
- ``subscript(_:)-2h8nh``

### Value Management

- ``value``
- ``hasValue``

### Change Tracking

- ``changedValueFlagged(options:)``
- ``wasModified(options:)``

### Associated Attribute

- ``attribute``