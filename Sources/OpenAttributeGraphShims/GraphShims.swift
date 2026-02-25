//
//  GraphShims.swift
//  OpenAttributeGraphShims

public enum AttributeGraphVendor: String {
    case oag = "org.OpenSwiftUIProject.OpenAttributeGraph"
    case ag = "com.apple.AttributeGraph"
    case compute = "dev.incrematic.compute"
}

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

@available(*, deprecated, renamed: "attributeGraphVendor")
public let attributeGraphEnabled = true
public let attributeGraphVendor = AttributeGraphVendor.compute

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

@available(*, deprecated, renamed: "attributeGraphVendor")
public let attributeGraphEnabled = true
public let attributeGraphVendor = AttributeGraphVendor.ag

#else

@_exported import OpenAttributeGraph
@available(*, deprecated, renamed: "attributeGraphVendor")
public let attributeGraphEnabled = false
public let attributeGraphVendor = AttributeGraphVendor.oag
#endif

@available(*, deprecated, message: "swiftToolchainSupported is always true")
public let swiftToolchainSupported = true
