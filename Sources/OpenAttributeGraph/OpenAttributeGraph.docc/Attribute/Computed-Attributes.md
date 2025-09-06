# Computed Attributes

Rule-based attributes that compute their values from other attributes.

## Overview

Computed attributes provide a declarative way to create attributes whose values are derived from other attributes. They use rule-based computation to automatically recalculate their values when dependencies change, forming the backbone of OpenAttributeGraph's reactive computation system.

Rules can be stateless for simple computations or stateful when they need to maintain internal state across updates. The Focus rule provides a specialized way to create attributes that track specific properties of other attributes using Swift's KeyPath system.

## Topics

### Rule Protocols

- ``Rule``
- ``StatefulRule``
- ``_AttributeBody``

### Specialized Rules

- ``Focus``
- ``External``

### Rule Creation

- ``Attribute/init(_:)-4tj1v``
- ``Attribute/init(_:)-8hz0z``
- ``Focus/init(root:keyPath:)``

### Rule Properties

- ``Rule/value``
- ``Rule/flags``
- ``StatefulRule/value``
- ``StatefulRule/flags``
- ``Focus/root``
- ``Focus/keyPath``
- ``Focus/value``

### Update Mechanisms

- ``Rule/_update``
- ``StatefulRule/_update``