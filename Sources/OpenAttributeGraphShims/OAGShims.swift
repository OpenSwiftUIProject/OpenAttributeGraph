//
//  AGShims.swift
//  OpenAttributeGraphShims

/// A type that identifies the underlying attribute graph implementation vendor.
///
/// Use `attributeGraphVendor` to check which vendor is active at runtime.
public struct AttributeGraphVendor: RawRepresentable, Hashable, CaseIterable {
    public let rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }

    /// OpenAttributeGraph — the open-source implementation by OpenSwiftUIProject.
    public static let oag = AttributeGraphVendor(rawValue: "org.OpenSwiftUIProject.OpenAttributeGraph")

    /// Apple's private AttributeGraph framework.
    public static let ag = AttributeGraphVendor(rawValue: "com.apple.AttributeGraph")

    /// An incremental computation library for Swift by @jcmosc
    public static let compute = AttributeGraphVendor(rawValue: "dev.incrematic.compute")

    public static var allCases: [AttributeGraphVendor] { [.oag, .ag, .compute] }
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

public let attributeGraphVendor = AttributeGraphVendor.ag

#else

@_exported import OpenAttributeGraph
public let attributeGraphVendor = AttributeGraphVendor.oag
#endif
