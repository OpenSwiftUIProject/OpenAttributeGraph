//
//  _AttributeBody.swift
//  OpenAttributeGraph
//
//  Audited for RELEASE_2021
//  Status: Complete

public import OpenAttributeGraphCxx

public protocol _AttributeBody {
    static func _destroySelf(_ pointer: UnsafeMutableRawPointer)
    static var _hasDestroySelf: Bool { get }
    static func _updateDefault(_ pointer: UnsafeMutableRawPointer)
    static var comparisonMode: ComparisonMode { get }
    typealias Flags = _AttributeType.Flags
    static var flags: Flags { get }
}

// MARK: - Protocol Default implementation

extension _AttributeBody {
    public static func _destroySelf(_ pointer: UnsafeMutableRawPointer) {}
    public static var _hasDestroySelf: Bool { false }
    public static func _updateDefault(_ pointer: UnsafeMutableRawPointer) {}
    public static var comparisonMode: ComparisonMode { .equatableUnlessPOD }
    public static var flags: Flags { .mainThread }
}

extension _AttributeBody {
    static func _visitBody<Visitor: AttributeBodyVisitor>(_ visitor: inout Visitor, _ body: UnsafeRawPointer) {
        visitor.visit(body: body.assumingMemoryBound(to: Self.self))
    }
}
