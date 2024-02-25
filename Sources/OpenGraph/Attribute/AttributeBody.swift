//
//  _AttributeBody.swift
//  OpenGraph
//
//  Updated by Kyle on 2024/2/16.
//  Lastest Version: iOS 15.5
//  Status: Complete

import _OpenGraph

public protocol _AttributeBody {
    static func _destroySelf(_ pointer: UnsafeMutableRawPointer)
    static var _hasDestroySelf: Bool { get }
    static func _updateDefault(_ pointer: UnsafeMutableRawPointer)
    static var comparisonMode: OGComparisonMode { get }
    static var flags: OGAttributeTypeFlags { get }
}

// MARK: - Protocol Default implementation

extension _AttributeBody {
    public static func _destroySelf(_ pointer: UnsafeMutableRawPointer) {}
    public static var _hasDestroySelf: Bool { false }
    public static func _updateDefault(_ pointer: UnsafeMutableRawPointer) {}
    public static var comparisonMode: OGComparisonMode { ._2 }
    public static var flags: OGAttributeTypeFlags { .mainThread }
}

extension _AttributeBody {
    static func _visitBody<Visitor: AttributeBodyVisitor>(_ visitor: inout Visitor, _ body: UnsafeRawPointer) {
        visitor.visit(body: body.assumingMemoryBound(to: Self.self))
    }
}
