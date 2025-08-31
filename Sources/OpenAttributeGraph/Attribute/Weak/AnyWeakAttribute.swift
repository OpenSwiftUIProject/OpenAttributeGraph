//
//  AnyWeakAttribute.swift
//  OpenAttributeGraph
//
//  Audited for 6.5.1
//  Status: Complete

public import OpenAttributeGraphCxx

// FIXME: For some unknown reason, AnyWeakAttribute and WeakAttribute's symbol can't be linked.

extension AnyWeakAttribute {
    @_alwaysEmitIntoClient
    public init(_ attribute: AnyAttribute?) {
        self = __OAGCreateWeakAttribute(attribute ?? .nil)
    }

    @_alwaysEmitIntoClient
    public init<Value>(_ weakAttribute: WeakAttribute<Value>) {
        self = weakAttribute.base
    }

    @_alwaysEmitIntoClient
    public func unsafeCast<Value>(to _: Value.Type) -> WeakAttribute<Value> {
        WeakAttribute(base: self)
    }

    @_alwaysEmitIntoClient
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
    @_alwaysEmitIntoClient
    public static func == (lhs: AnyWeakAttribute, rhs: AnyWeakAttribute) -> Bool {
        lhs._details.identifier == rhs._details.identifier && lhs._details.seed == rhs._details.seed
    }

    @_alwaysEmitIntoClient
    public func hash(into hasher: inout Hasher) {
        hasher.combine(_details.identifier)
        hasher.combine(_details.seed)
    }

    @_alwaysEmitIntoClient
    public var hashValue: Int {
        _hashValue(for: self)
    }
}

extension AnyWeakAttribute: Swift.CustomStringConvertible {
    @_alwaysEmitIntoClient
    public var description: String { attribute?.description ?? "nil" }
}
