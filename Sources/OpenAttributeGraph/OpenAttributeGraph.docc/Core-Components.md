# Core Components

The fundamental building blocks of OpenAttributeGraph's reactive programming system.

## Overview

OpenAttributeGraph provides a comprehensive set of components for building reactive applications. These core components work together to provide automatic dependency tracking, efficient updates, and a clean programming model.

## Attributes

The foundation of the reactive system, providing property wrappers and type-erased access to reactive values.

- ``Attribute`` - The primary property wrapper for reactive values
- ``AnyAttribute`` - Type-erased attribute for runtime flexibility
- ``WeakAttribute`` - Weak reference attribute wrapper
- ``AnyWeakAttribute`` - Type-erased weak attribute
- ``OptionalAttribute`` - Optional value attribute wrapper  
- ``AnyOptionalAttribute`` - Type-erased optional attribute
- ``IndirectAttribute`` - Indirect attribute for complex reference scenarios

## Rules and Transformations

Protocols and types for creating computed attributes that derive their values from other attributes.

- ``Rule`` - Protocol for stateless computed attributes
- ``StatefulRule`` - Protocol for stateful computed attributes  
- ``Focus`` - Rule for focusing on part of an attribute's value
- ``Map`` - Rule for transforming attribute values

## Graph Management

Types that manage the dependency graph and coordinate updates across attributes.

- ``Graph`` - Central coordinator for attribute relationships and updates
- ``Subgraph`` - Scoped computation context for isolated attribute groups

## Runtime Support

Low-level utilities for type introspection, comparison, and memory management.

- ``Metadata`` - Swift runtime type information and reflection
- ``compareValues(_:_:mode:)`` - Efficient value comparison across types
- ``TupleType`` - Runtime support for tuple types and operations

## Debugging and Development

Tools for debugging attribute graphs and monitoring performance.

- ``DebugServer`` - Server for debugging and introspecting attribute graphs