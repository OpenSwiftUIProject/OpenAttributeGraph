# ``OpenAttributeGraph``

A high-performance reactive programming framework that powers SwiftUI's underlying dependency tracking and update system.

## Overview

OpenAttributeGraph is an open source implementation of Apple's private AttributeGraph framework. It provides a reactive programming model built around attributes that automatically track dependencies and efficiently propagate changes through a dependency graph.

The framework is designed for high performance and powers the reactive updates that make SwiftUI interfaces responsive and efficient.

## Topics

### Architecture

- <doc:Architecture-article>

### Core Components

#### Attributes
- ``Attribute``
- ``AnyAttribute``
- ``WeakAttribute``
- ``AnyWeakAttribute``
- ``OptionalAttribute``
- ``AnyOptionalAttribute``
- ``IndirectAttribute``

#### Rules and Transformations
- ``Rule``
- ``StatefulRule``
- ``Focus``
- ``Map``

#### Graph Management
- ``Graph``
- ``Subgraph``

#### Runtime Support
- ``Metadata``
- ``compareValues(_:_:mode:)``
- ``TupleType``

#### Debugging and Development
- ``DebugServer``

### Advanced Topics

#### Attribute Bodies
- ``_AttributeBody``
- ``AttributeBodyVisitor``
- ``ObservedAttribute``

#### Context Management
- ``RuleContext``
- ``AnyRuleContext``

#### Type System Support
- ``External``
- ``PointerOffset``