# ``Subgraph``

Scoped computation contexts for isolated attribute groups.

## Overview

`Subgraph` provides scoped computation contexts that allow for isolated attribute groups with separate update domains. This enables better performance by reducing the scope of updates and provides isolated environments for testing.

Subgraphs are essential for organizing complex attribute hierarchies and controlling the scope of reactive updates.

## Key Features

- Isolation: Separate update domains for different parts of your application
- Performance: Smaller update scopes reduce computational overhead
- Testing: Isolated environments for unit testing
- Observer pattern: Add observers for subgraph changes

## Usage Pattern

Subgraphs are commonly used to:
- Isolate different UI components or modules
- Create test environments with controlled attribute scopes
- Optimize performance by limiting update propagation
- Implement hierarchical reactive systems

## Topics

### Type Aliases

- ``Flags``
- ``ChildFlags``

### Observers

- ``addObserver(_:)``

### Scoped Execution

- ``apply(_:)``

### Attribute Iteration

- ``forEach(_:_:)``

### Global Access

- ``current``
- ``currentGraphContext``