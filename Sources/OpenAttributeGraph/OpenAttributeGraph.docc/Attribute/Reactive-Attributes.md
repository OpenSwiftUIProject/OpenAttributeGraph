# Reactive Attributes

Reactive properties that automatically track dependencies and manage value updates.

## Overview

Reactive attributes form the foundation of OpenAttributeGraph's reactive programming model. These attributes automatically track their dependencies and efficiently propagate changes through the dependency graph when their values change.

The primary reactive attribute types provide different levels of memory management and reference semantics to handle various use cases in reactive applications.

## Topics

### Core Reactive Types

- ``Attribute``
- ``WeakAttribute``
- ``OptionalAttribute``

### Property Wrapper Support

- ``Attribute/wrappedValue``
- ``Attribute/projectedValue``
- ``WeakAttribute/wrappedValue``
- ``WeakAttribute/projectedValue``

### Dynamic Member Access

- ``Attribute/subscript(dynamicMember:)``
- ``WeakAttribute/subscript(dynamicMember:)``

### Value Management

- ``Attribute/value``
- ``Attribute/setValue(_:)``
- ``WeakAttribute/value``
- ``WeakAttribute/changedValue(options:)``