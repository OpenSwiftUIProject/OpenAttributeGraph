//
//  AnyAttribute.swift
//  OpenAttributeGraph
//
//  Audited for 3.2.1
//  Status: API complete

public import OpenAttributeGraphCxx

@_silgen_name("OAGGraphMutateAttribute")
private func OAGGraphMutateAttribute(
    _ attribute: AnyAttribute,
    type: Metadata,
    invalidating: Bool,
    body: (UnsafeMutableRawPointer) -> Void
)

extension AnyAttribute {
    public init<Value>(_ attribute: Attribute<Value>) {
        self = attribute.identifier
    }

    public func unsafeCast<Value>(to _: Value.Type) -> Attribute<Value> {
        Attribute<Value>(identifier: self)
    }

    public static var current: AnyAttribute? {
        let current = __OAGGraphGetCurrentAttribute()
        return current == .nil ? nil : current
    }

    public func unsafeOffset(at offset: Int) -> AnyAttribute {
        create(offset: offset)
    }

    public func setFlags(_ newFlags: Flags, mask: Flags) {
        flags = flags.subtracting(mask).union(newFlags.intersection(mask))
    }

    public func addInput(_ attribute: AnyAttribute, options: OAGInputOptions = [], token: Int) {
        __OAGGraphAddInput(self, attribute, options, token)
    }

    public func addInput<Value>(_ attribute: Attribute<Value>, options: OAGInputOptions = [], token: Int) {
        addInput(attribute.identifier, options: options, token: token)
    }

    // FIXME: Use AttributeType instead
    public func visitBody<Body: AttributeBodyVisitor>(_ visitor: inout Body) {
        let bodyType = info.type.advanced(by: 1).pointee.self_id.type as! _AttributeBody.Type
        bodyType._visitBody(&visitor, info.body)
    }

    public func mutateBody<Value>(as type: Value.Type, invalidating: Bool, _ body: (inout Value) -> Void) {
        OAGGraphMutateAttribute(
            self,
            type: Metadata(type),
            invalidating: invalidating
        ) { value in
            body(&value.assumingMemoryBound(to: Value.self).pointee)
        }
    }

    public func breadthFirstSearch(options _: SearchOptions = [], _: (AnyAttribute) -> Bool) -> Bool {
        fatalError("TODO")
    }

    public var _bodyType: Any.Type {
        info.type.pointee.self_id.type
    }

    public var _bodyPointer: UnsafeRawPointer {
        info.body
    }

    public var valueType: Any.Type {
        info.type.pointee.value_id.type
    }

    public var indirectDependency: AnyAttribute? {
        get {
            let indirectDependency = _indirectDependency
            return indirectDependency == .nil ? nil : indirectDependency
        }
        nonmutating set {
            _indirectDependency = newValue ?? .nil
        }
    }
}

// MARK: CustomStringConvertible

extension AnyAttribute: Swift.CustomStringConvertible {
    @inlinable
    public var description: String { "#\(rawValue)" }
}

public typealias AttributeUpdateBlock = () -> (UnsafeMutableRawPointer, AnyAttribute) -> Void
