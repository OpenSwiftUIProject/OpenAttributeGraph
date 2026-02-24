//
//  AnyRuleContext.swift
//  OpenAttributeGraph
//
//  Audited for 3.2.1
//  Status: Complete

public import OpenAttributeGraphCxx

@frozen
public struct AnyRuleContext: Equatable {
    public var attribute: AnyAttribute
    
    public init(attribute: AnyAttribute) {
        self.attribute = attribute
    }
    
    public init<V>(_ context: RuleContext<V>) {
        attribute = context.attribute.identifier
    }
    
    public subscript<V>(attribute: Attribute<V>) -> V {
        unsafeAddress {
            OAGGraphGetInputValue(self.attribute, input: attribute.identifier, type: V.self)
                .value
                .assumingMemoryBound(to: V.self)
        }
    }
    
    public subscript<V>(weakAttribute: WeakAttribute<V>) -> V? {
        weakAttribute.attribute.map { attribute in
            OAGGraphGetInputValue(self.attribute, input: attribute.identifier, type: V.self)
                .value
                .assumingMemoryBound(to: V.self)
                .pointee
        }
    }
    
    public subscript<V>(optionalAttribute: OptionalAttribute<V>) -> V? {
        optionalAttribute.attribute.map { attribute in
            OAGGraphGetInputValue(self.attribute, input: attribute.identifier, type: V.self)
                .value
                .assumingMemoryBound(to: V.self)
                .pointee
        }
    }
    
    public func valueAndFlags<V>(of input: Attribute<V>, options: OAGValueOptions = []) -> (value: V, flags: OAGChangedValueFlags) {
        let value = OAGGraphGetInputValue(attribute, input: input.identifier, options: options, type: V.self)
        return (
            value.value.assumingMemoryBound(to: V.self).pointee,
            value.flags
        )
    }
    
    public func changedValue<V>(of input: Attribute<V>, options: OAGValueOptions = []) -> (value: V, changed: Bool) {
        let value = OAGGraphGetInputValue(attribute, input: input.identifier, options: options, type: V.self)
        return (
            value.value.assumingMemoryBound(to: V.self).pointee,
            value.flags.contains(.changed)
        )
    }
    
    public func update(body: () -> Void) {
        OAGGraphWithUpdate(attribute, body: body)
    }
    
    public func unsafeCast<V>(to _: V.Type) -> RuleContext<V> {
        RuleContext(attribute: Attribute(identifier: attribute))
    }
}
