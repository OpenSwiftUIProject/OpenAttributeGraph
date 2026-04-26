//
//  Compute.swift
//  OpenAttributeGraphShims

#if OPENATTRIBUTEGRAPH_COMPUTE

@_exported public import Compute

public typealias OAGAttributeInfo = AGAttributeInfo
public typealias OAGCachedValueOptions = CachedValueOptions
public typealias OAGChangedValueFlags = AGChangedValueFlags
public typealias OAGInputOptions = AGInputOptions
public typealias OAGValue = AGChangedValue
public typealias OAGValueOptions = AGValueOptions

extension AnyAttribute {
    public typealias Flags = Subgraph.Flags

    public var subgraph2: Subgraph? { nil }
}

extension Subgraph {
    public typealias ChildFlags = AnyAttribute.Flags
}

extension Graph {
    public static func startProfiling() {
        startProfiling(nil)
    }

    public static func stopProfiling() {
        stopProfiling(nil)
    }

    public func startProfiling() {
        Self.startProfiling(self)
    }

    public func stopProfiling() {
        Self.stopProfiling(self)
    }

    public func resetProfile() {
        // TODO: placeholder
    }
}

extension _AttributeBody {
    public typealias Flags = _AttributeType.Flags
}

extension CachedValueOptions {
    public static var _1: CachedValueOptions = .unprefetched
}

public let attributeGraphVendor = AttributeGraphVendor.compute

#endif
