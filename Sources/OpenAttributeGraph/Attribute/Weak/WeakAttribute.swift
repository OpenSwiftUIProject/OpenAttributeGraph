//
//  WeakAttribute.swift
//  OpenAttributeGraph
//
//  Audited for 6.5.1
//  Status: Complete

public import OpenAttributeGraphCxx

@frozen
@propertyWrapper
@dynamicMemberLookup
public struct WeakAttribute<Value> {
    var base: AnyWeakAttribute
    
    public init(base: AnyWeakAttribute) {
        self.base = base
    }
    
    public init() {
        base = AnyWeakAttribute(_details: .init(identifier: .init(rawValue: 0), seed: 0))
    }
    
    public init(_ attribute: Attribute<Value>) {
        base = AnyWeakAttribute(attribute.identifier)
    }
    
    public init(_ attribute: Attribute<Value>?) {
        base = AnyWeakAttribute(attribute?.identifier)
    }
    
    public var wrappedValue: Value? {
        OAGGraphGetWeakValue(base, type: Value.self)
            .value?
            .assumingMemoryBound(to: Value.self)
            .pointee
    }
    
    public var projectedValue: Attribute<Value>?{
        get { attribute }
        set { attribute = newValue }
        _modify { yield &attribute }
    }
    
    public subscript<Member>(dynamicMember keyPath: KeyPath<Value, Member>) -> Attribute<Member>? {
        attribute?[keyPath: keyPath]
    }
    
    public var attribute: Attribute<Value>? {
        get { base.attribute?.unsafeCast(to: Value.self) }
        set { base.attribute = newValue?.identifier }
    }
    
    public var value: Value? { wrappedValue }

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
private func OAGGraphGetWeakValue<Value>(_ attribute: AnyWeakAttribute, options: OAGValueOptions = [], type: Value.Type = Value.self) -> OAGWeakValue
