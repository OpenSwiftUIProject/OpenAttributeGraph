//
//  StatefulRule.swift
//  OpenAttributeGraph
//
//  Audited for 3.2.1
//  Status: Complete

public import OpenAttributeGraphCxx

/// A protocol for defining computed attributes that maintain state between evaluations.
///
/// `StatefulRule` extends the basic `Rule` concept by allowing rules to maintain mutable state between updates. This is useful for rules that need to track changes over time or maintain internal state.
///
///     struct CounterRule: StatefulRule {
///         typealias Value = Int
///         private var counter = 0
///         
///         mutating func updateValue() {
///             counter += 1
///             value = counter
///         }
///     }
///
/// Unlike ``Rule``, `StatefulRule` allows mutation through the `updateValue()` method and provides direct access to the current value through the `value` property.
///
/// ## Key Features
///
/// - Mutable state: Rules can maintain and modify internal state
/// - Direct value access: Read and write the current value directly
/// - Context access: Access to rule evaluation context and attribute
/// - Lifecycle control: Manual control over when and how values update
///
/// ## Usage Pattern
///
/// StatefulRule is ideal for scenarios where you need to:
/// - Accumulate values over time
/// - Maintain counters or timers
/// - Implement complex state machines
/// - Cache expensive computations with custom invalidation
public protocol StatefulRule: _AttributeBody {
    associatedtype Value
    static var initialValue: Value? { get }
    mutating func updateValue()
}

// MARK: - StatefulRule Protocol default implementation

extension StatefulRule {
    public static var initialValue: Value? { nil }

    public static func _update(_ pointer: UnsafeMutableRawPointer, attribute _: AnyAttribute) {
        pointer.assumingMemoryBound(to: Self.self)
            .pointee
            .updateValue()
    }

    public static func _updateDefault(_: UnsafeMutableRawPointer) {
        guard let initialValue else {
            return
        }
        withUnsafePointer(to: initialValue) { value in
            Graph.setOutputValue(value)
        }
    }
}

// MARK: - StatefulRule extension

extension StatefulRule {
    public var attribute: Attribute<Value> {
        Attribute<Value>(identifier: AnyAttribute.current!)
    }

    public var context: RuleContext<Value> {
        RuleContext<Value>(attribute: attribute)
    }
    
    public var value: Value {
        unsafeAddress { Graph.outputValue()! }
        nonmutating set { context.value = newValue }
    }
    
    public var hasValue: Bool { context.hasValue }
}
