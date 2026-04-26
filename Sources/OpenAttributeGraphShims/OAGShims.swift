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

    /// ByteDance DanceUIGraph.
    public static let danceUIGraph = AttributeGraphVendor(rawValue: "com.bytedance.danceui.graph")

    public static var allCases: [AttributeGraphVendor] { [.oag, .ag, .compute, .danceUIGraph] }
}

#if !OPENATTRIBUTEGRAPH_COMPUTE && !OPENATTRIBUTEGRAPH_DANCEUIGRAPH && !OPENATTRIBUTEGRAPH_ATTRIBUTEGRAPH
@_exported import OpenAttributeGraph
public let attributeGraphVendor = AttributeGraphVendor.oag
#endif
