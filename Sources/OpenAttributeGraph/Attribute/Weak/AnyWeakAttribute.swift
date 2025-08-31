//
//  AnyWeakAttribute.swift
//  OpenAttributeGraph
//
//  Audited for 6.5.1
//  Status: Complete

public import OpenAttributeGraphCxx

extension AnyWeakAttribute {
    public init(_ attribute: AnyAttribute?) {
        self = __OAGCreateWeakAttribute(attribute ?? .nil)
    }

    public init<Value>(_ weakAttribute: WeakAttribute<Value>) {
        self = weakAttribute.base
    }
    
    public func unsafeCast<Value>(to _: Value.Type) -> WeakAttribute<Value> {
        WeakAttribute(base: self)
    }
    
    public var attribute: AnyAttribute? {
        get {
            let attribute = __OAGWeakAttributeGetAttribute(self)
            return attribute == .nil ? nil : attribute
        }
        set {
            self = AnyWeakAttribute(newValue)
        }
    }
}

extension AnyWeakAttribute: Swift.Hashable {
    public static func == (lhs: AnyWeakAttribute, rhs: AnyWeakAttribute) -> Bool {
        lhs._details.identifier == rhs._details.identifier && lhs._details.seed == rhs._details.seed
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(_details.identifier)
        hasher.combine(_details.seed)
    }
    
    public var hashValue: Int {
        _hashValue(for: self)
    }
}

extension AnyWeakAttribute: Swift.CustomStringConvertible {
    public var description: String { attribute?.description ?? "nil" }
}
