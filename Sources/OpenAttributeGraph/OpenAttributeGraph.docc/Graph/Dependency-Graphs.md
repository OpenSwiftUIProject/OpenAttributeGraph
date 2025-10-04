# Dependency Graphs

Graph structures that manage attribute dependencies and updates.

## Overview

Dependency graphs form the backbone of OpenAttributeGraph's reactive system, managing relationships between attributes and coordinating updates when values change. The graph system uses a two-level hierarchy with global graphs containing multiple subgraphs for efficient organization and update propagation.

Graphs automatically track dependencies as attributes access other attributes during computation, building an efficient dependency network that minimizes unnecessary recalculations when changes occur.

## Topics

### Graph Types

- ``Graph``
- ``Subgraph``

### Graph Creation

- ``Graph/init()``
- ``Subgraph/init()``

### Graph Management

- ``Graph/typeIndex(ctx:body:makeAttributeType:)``
- ``Subgraph/currentGraphContext``

### Update Coordination

- ``Graph/willInvalidate(attribute:)``
- ``Graph/updateValue()``
- ``Subgraph/update()``

### Graph Traversal

- ``Attribute/breadthFirstSearch(options:_:)``
- ``AnyAttribute/breadthFirstSearch(options:_:)``

### Input Management

- ``Attribute/addInput(_:options:token:)``
- ``Attribute/addInput(_:options:token:)-6p8bn``
- ``AnyAttribute/addInput(_:options:token:)``

### Graph Properties

- ``Attribute/graph``
- ``Attribute/subgraph``
- ``AnyAttribute/graph``
- ``AnyAttribute/subgraph``