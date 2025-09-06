# ``StatefulRule``

A protocol for defining computed attributes that maintain state between evaluations.

## Overview

`StatefulRule` extends the basic `Rule` concept by allowing rules to maintain mutable state between updates. This is useful for rules that need to track changes over time or maintain internal state.

    struct CounterRule: StatefulRule {
        typealias Value = Int
        private var counter = 0
        
        mutating func updateValue() {
            counter += 1
            value = counter
        }
    }

Unlike ``Rule``, `StatefulRule` allows mutation through the `updateValue()` method and provides direct access to the current value through the `value` property.

## Key Features

- Mutable state: Rules can maintain and modify internal state
- Direct value access: Read and write the current value directly
- Context access: Access to rule evaluation context and attribute
- Lifecycle control: Manual control over when and how values update

## Usage Pattern

StatefulRule is ideal for scenarios where you need to:
- Accumulate values over time
- Maintain counters or timers
- Implement complex state machines
- Cache expensive computations with custom invalidation

## Topics

### Protocol Requirements

- ``Value``
- ``initialValue``
- ``updateValue()``

### Value Management

- ``value``
- ``hasValue``

### Context Access

- ``attribute``
- ``context``