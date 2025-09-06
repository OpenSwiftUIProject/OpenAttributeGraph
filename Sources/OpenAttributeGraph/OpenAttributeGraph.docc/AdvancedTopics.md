# AdvancedTopics

Advanced features and implementation details for sophisticated use cases.

## Overview

These advanced topics cover specialized functionality and implementation details that are useful for complex scenarios and deep integration with OpenAttributeGraph's reactive system.

## Attribute Bodies

Low-level attribute implementation and visitor patterns for advanced attribute manipulation.

- ``AttributeBodyVisitor`` - Protocol for visiting and inspecting attribute bodies
- ``ObservedAttribute`` - Attribute wrapper for observing changes in other attributes

## Context Management

Types for managing evaluation contexts and rule execution environments.

- ``RuleContext`` - Context object providing access to rule evaluation state
- ``AnyRuleContext`` - Type-erased rule context for runtime flexibility

## Type System Support

Utilities for working with external values and memory layout manipulation.

- ``External`` - Wrapper for external values not managed by the attribute graph
- ``PointerOffset`` - Type-safe pointer arithmetic for nested attribute access