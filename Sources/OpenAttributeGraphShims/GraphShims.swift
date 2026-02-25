//
//  GraphShims.swift
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
}

extension AnyAttribute {
    public var subgraph2: Subgraph? { nil }
}


extension Subgraph {
    public typealias ChildFlags = AnyAttribute.Flags
}

extension Graph {
    public func startProfiling() {
        // TODO: placeholder
    }
    
    public func stopProfiling() {
        // TODO: placeholder
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

public let attributeGraphEnabled = true
#elseif OPENATTRIBUTEGRAPH_ATTRIBUTEGRAPH
@_exported public import AttributeGraph
#if os(iOS) && !targetEnvironment(simulator)
@_exported public import _AttributeGraphDeviceSwiftShims
#endif
public typealias OAGAttributeInfo = AGAttributeInfo
public typealias OAGCachedValueOptions = AGCachedValueOptions
public typealias OAGChangedValueFlags = AGChangedValueFlags
public typealias OAGInputOptions = AGInputOptions
public typealias OAGValue = AGValue
public typealias OAGValueOptions = AGValueOptions
public let attributeGraphEnabled = true
#else
@_exported import OpenAttributeGraph

public let attributeGraphEnabled = false
#endif

@available(*, deprecated, message: "swiftToolchainSupported is always true")
public let swiftToolchainSupported = true
