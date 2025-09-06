# Architecture

Understanding OpenAttributeGraph's three-layer architecture: Attributes, Graph, and Runtime.

## Overview

OpenAttributeGraph is built around a three-layer architecture that provides a complete reactive programming system. Each layer serves a specific purpose in the overall framework, working together to deliver high-performance reactive updates.

## The Three Layers

### Attribute Layer

The **Attribute layer** forms the foundation of the reactive system, providing the building blocks for trackable, reactive values.

#### Core Concepts

**Property Wrapper Design**: At its heart, ``Attribute`` is a property wrapper that makes any Swift value reactive. When you wrap a value with `@Attribute`, it automatically gains dependency tracking capabilities:

```swift
@Attribute var count: Int = 0
```

**Type Erasure**: ``AnyAttribute`` provides type-erased access to attributes, enabling runtime flexibility while maintaining type safety where possible.

**Rule-Based Transformations**: The ``Rule`` and ``StatefulRule`` protocols allow you to create computed attributes that automatically update when their dependencies change:

```swift
struct DoubledRule: Rule {
    typealias Value = Int
    let source: Attribute<Int>
    
    func value() -> Int {
        source.wrappedValue * 2
    }
}
```

**Reference Semantics**: ``WeakAttribute`` and ``OptionalAttribute`` provide safe ways to handle optional and weak references within the attribute system.

#### Body System

The attribute body system optimizes performance through:
- **Lazy evaluation**: Values are only computed when needed
- **Caching**: Results are cached until dependencies change
- **Efficient invalidation**: Only affected attributes are marked for recomputation

### Graph Layer

The **Graph layer** manages the dependency network between attributes and orchestrates efficient updates.

#### Dependency Management

The ``Graph`` maintains a directed acyclic graph (DAG) of attribute dependencies:

- **Automatic tracking**: Dependencies are discovered automatically when attributes are accessed during rule evaluation
- **Cycle detection**: The system prevents and detects circular dependencies
- **Batch updates**: Multiple changes are batched together for optimal performance

#### Update Propagation

When an attribute changes, the graph efficiently propagates updates:

1. **Mark phase**: Changed attributes are marked as invalid
2. **Sweep phase**: Dependent attributes are transitively marked
3. **Update phase**: Values are recomputed in dependency order

#### Subgraphs

``Subgraph`` provides scoped computation contexts that allow:
- **Isolation**: Separate update domains for different parts of your application
- **Performance**: Smaller update scopes reduce computational overhead
- **Testing**: Isolated environments for unit testing

### Runtime Layer

The **Runtime layer** provides the low-level type introspection and memory management that makes the higher layers possible.

#### Type Introspection

``Metadata`` provides Swift runtime type information:
- **Field enumeration**: Discover the fields of any Swift type at runtime
- **Layout information**: Access memory layout and alignment details
- **Type comparison**: Efficiently compare types and values

This runtime introspection enables features like automatic KeyPath-based attribute access:

```swift
@Attribute var person: Person = Person(name: "Alice", age: 30)
let nameAttribute = person.name  // Automatic attribute creation via KeyPath
```

#### Memory Management

The runtime layer handles:
- **Pointer arithmetic**: Safe offset calculations for nested attribute access
- **Type-safe casting**: Runtime type validation and casting
- **Value comparison**: Efficient equality checking across different types

#### Integration with Swift Runtime

> **Note**: The Runtime layer leverages techniques similar to those found in [wickwirew/Runtime](https://github.com/wickwirew/Runtime) for Swift runtime introspection and type manipulation.

The system integrates deeply with Swift's runtime to:
- Access private metadata structures safely
- Perform efficient type conversions
- Handle dynamic member lookup for attributes

## How the Layers Work Together

### Creating an Attribute

When you create an attribute, all three layers collaborate:

1. **Runtime layer**: Introspects the value type and creates metadata
2. **Graph layer**: Allocates space in the dependency graph
3. **Attribute layer**: Wraps the value in a reactive property wrapper

### Dependency Tracking

During rule evaluation:

1. **Attribute layer**: Rules access their dependency attributes
2. **Graph layer**: Records these accesses as dependencies
3. **Runtime layer**: Handles type-safe value extraction and conversion

### Update Propagation

When a change occurs:

1. **Attribute layer**: Detects the value change
2. **Graph layer**: Propagates invalidation through dependencies
3. **Runtime layer**: Provides efficient value comparison to minimize updates

## Performance Characteristics

The three-layer architecture enables several performance optimizations:

- **Minimal allocations**: Attributes reuse storage and minimize memory churn
- **Lazy evaluation**: Computations are deferred until values are actually needed
- **Batch processing**: Multiple updates are processed together
- **Cache efficiency**: Hot paths through the dependency graph are optimized

## Design Patterns

The architecture encourages several beneficial patterns:

### Composition over Inheritance
Attributes compose naturally through rules and transformations rather than class hierarchies.

### Functional Reactive Programming
The rule system encourages pure, functional transformations of data.

### Declarative Updates
Changes propagate automatically without explicit update calls.

## Debugging and Introspection

Each layer provides debugging capabilities:

- **Attribute layer**: Inspect individual attribute values and states
- **Graph layer**: Visualize dependency relationships and update cycles  
- **Runtime layer**: Examine type metadata and memory layout

The ``DebugServer`` provides a unified interface for debugging across all layers.