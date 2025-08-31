//
//  WeakAttribute.swift
//  OpenAttributeGraph
//
//  Audited for 6.5.1
//  Status: Complete

public import OpenAttributeGraphCxx

// FIXME: For some unknown reason, AnyWeakAttribute and WeakAttribute's symbol can't be linked.

@frozen
@propertyWrapper
@dynamicMemberLookup
public struct WeakAttribute<Value> {
    @usableFromInline
    var base: AnyWeakAttribute

    @_alwaysEmitIntoClient
    public init(base: AnyWeakAttribute) {
        self.base = base
    }

    @_alwaysEmitIntoClient
    public init() {
        base = AnyWeakAttribute(_details: .init(identifier: .init(rawValue: 0), seed: 0))
    }

    @_alwaysEmitIntoClient
    public init(_ attribute: Attribute<Value>) {
        base = AnyWeakAttribute(attribute.identifier)
    }

    @_alwaysEmitIntoClient
    public init(_ attribute: Attribute<Value>?) {
        base = AnyWeakAttribute(attribute?.identifier)
    }

    @_alwaysEmitIntoClient
    public var wrappedValue: Value? {
        OAGGraphGetWeakValue(base, type: Value.self)
            .value?
            .assumingMemoryBound(to: Value.self)
            .pointee
    }

    @_alwaysEmitIntoClient
    public var projectedValue: Attribute<Value>?{
        get { attribute }
        set { attribute = newValue }
        _modify { yield &attribute }
    }

    @_alwaysEmitIntoClient
    public subscript<Member>(dynamicMember keyPath: KeyPath<Value, Member>) -> Attribute<Member>? {
        attribute?[keyPath: keyPath]
    }

    @_alwaysEmitIntoClient
    public var attribute: Attribute<Value>? {
        get { base.attribute?.unsafeCast(to: Value.self) }
        set { base.attribute = newValue?.identifier }
    }

    @_alwaysEmitIntoClient
    public var value: Value? { wrappedValue }

    @_alwaysEmitIntoClient
    public func changedValue(options: OAGValueOptions) -> (value: Value, changed: Bool)? {
        let value = OAGGraphGetWeakValue(base, options: options, type: Value.self)
        guard let ptr = value.value else {
            return nil
        }
        return (
            ptr.assumingMemoryBound(to: Value.self).pointee,
            value.flags.contains(.changed)
        )
    }
}

extension WeakAttribute: Hashable {}

extension WeakAttribute: CustomStringConvertible {
    public var description: String { base.description }
}

@_silgen_name("OAGGraphGetWeakValue")
@_alwaysEmitIntoClient
private func OAGGraphGetWeakValue<Value>(_ attribute: AnyWeakAttribute, options: OAGValueOptions = [], type: Value.Type = Value.self) -> OAGWeakValue
