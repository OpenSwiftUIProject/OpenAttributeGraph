//
//  _AttributeBody.swift
//  OpenAttributeGraph
//
//  Audited for 3.2.1
//  Status: Complete

public import OpenAttributeGraphCxx

/// A protocol for defining computed attributes that automatically update when dependencies change.
///
/// Rules provide a way to create derived attributes that compute their values based on other attributes.
/// When any dependency changes, the rule will automatically recompute its value.
///
///     struct DoubledRule: Rule {
///         typealias Value = Int
///         let source: Attribute<Int>
///
///         var value: Int {
///             source.wrappedValue * 2
///         }
///     }
///
///     @Attribute var count: Int = 5
///     let doubled = Attribute(DoubledRule(source: $count))
///     // doubled.wrappedValue == 10
///
///     count = 10
///     // doubled.wrappedValue automatically becomes 20
///
/// ## Key Features
///
/// - Automatic dependency tracking: Dependencies are discovered automatically when accessed
/// - Lazy evaluation: Values are only computed when needed
/// - Caching: Results are cached until dependencies change
/// - Efficient updates: Only recomputes when dependencies actually change
///
/// ## Implementation Requirements
///
/// Types conforming to `Rule` must provide:
/// - `Value`: The type of value produced by the rule
/// - `value`: A computed property that returns the current value
/// - `initialValue`: An optional initial value (defaults to `nil`)
///
/// ## Advanced Usage
///
/// For rules that need to maintain state between evaluations, see ``StatefulRule``.
/// For rules that can be cached based on their content, make your rule type conform to `Hashable`.
public protocol Rule: _AttributeBody {
    /// The type of value produced by this rule.
    associatedtype Value

    /// An optional initial value to use before the rule is first evaluated.
    static var initialValue: Value? { get }

    /// Computes and returns the current value of the rule.
    var value: Value { get }
}

// MARK: - Rule Protocol default implementation

extension Rule {
    public static var initialValue: Value? { nil }

    public static func _update(_ pointer: UnsafeMutableRawPointer, attribute _: AnyAttribute) {
        let rule = pointer.assumingMemoryBound(to: Self.self)
        let value = rule.pointee.value
        // Verified for 5.0.77
        withUnsafePointer(to: value) { value in
            Graph.setOutputValue(value)
        }
    }

    public static func _updateDefault(_: UnsafeMutableRawPointer) {
        guard let initialValue else {
            return
        }
        // Verified for 5.0.77
        withUnsafePointer(to: initialValue) { value in
            Graph.setOutputValue(value)
        }
    }
}

// MARK: - Rule extension

extension Rule {
    public var attribute: Attribute<Value> {
        Attribute<Value>(identifier: AnyAttribute.current!)
    }

    public var context: RuleContext<Value> {
        RuleContext<Value>(attribute: attribute)
    }
}

// MARK: - Rule extension for Hashable Value

extension Rule where Self: Hashable {
    public func cachedValue(
        options: OAGCachedValueOptions = [],
        owner: AnyAttribute?
    ) -> Value {
        withUnsafePointer(to: self) { pointer in
            Self._cachedValue(
                options: options,
                owner: owner,
                hashValue: hashValue,
                bodyPtr: pointer,
                update: { Self._update }
            ).pointee
        }
    }

    public func cachedValueIfExists(
        options: OAGCachedValueOptions = [],
        owner: AnyAttribute?
    ) -> Value? {
        withUnsafePointer(to: self) { bodyPointer in
            let value = __OAGGraphReadCachedAttributeIfExists(
                hashValue,
                Metadata(Self.self),
                bodyPointer,
                Metadata(Value.self),
                options,
                owner ?? .nil,
                false
            )
            guard let value else { return nil }
            return value.assumingMemoryBound(to: Value.self).pointee
        }
    }

    public static func _cachedValue(
        options: OAGCachedValueOptions = [],
        owner: AnyAttribute?,
        hashValue: Int,
        bodyPtr: UnsafeRawPointer,
        update: AttributeUpdateBlock
    ) -> UnsafePointer<Value> {
        // TODO: pass closure here
        __OAGGraphReadCachedAttribute(
            hashValue,
            Metadata(Self.self),
            bodyPtr,
            Metadata(Value.self),
            options,
            owner ?? .nil,
            false
        )
        .assumingMemoryBound(to: Value.self)
    }
}
