# ``Graph``

The central coordinator for attribute relationships and update cycles.

## Overview

`Graph` manages the dependency network between attributes and orchestrates efficient updates across the entire reactive system. It maintains a directed acyclic graph (DAG) of attribute dependencies and handles the propagation of changes.

The graph automatically tracks dependencies when attributes are accessed during rule evaluation, detects cycles, and batches updates for optimal performance.

## Key Features

- Dependency tracking: Automatically discovers and maintains attribute relationships
- Cycle detection: Prevents and detects circular dependencies
- Batch updates: Groups multiple changes for efficient processing
- Update scheduling: Coordinates when and how attributes are recomputed
- Performance monitoring: Profiling and debugging capabilities

## Update Propagation

When an attribute changes, the graph efficiently propagates updates through three phases:
1. Mark phase: Changed attributes are marked as invalid
2. Sweep phase: Dependent attributes are transitively marked  
3. Update phase: Values are recomputed in dependency order

## Topics

### Update Control

- ``withoutUpdate(_:)``
- ``withoutSubgraphInvalidation(_:)``
- ``withDeadline(_:_:)``

### Callbacks

- ``onInvalidation(_:)``
- ``onUpdate(_:)``

### Performance Monitoring

- ``startProfiling()``
- ``stopProfiling()``
- ``resetProfile()``

### Statistics

- ``mainUpdates``

### Global Operations

- ``anyInputsChanged(excluding:)``

### Output Management

- ``outputValue()``
- ``setOutputValue(_:)``

### Archive and Debug

- ``archiveJSON(name:)``