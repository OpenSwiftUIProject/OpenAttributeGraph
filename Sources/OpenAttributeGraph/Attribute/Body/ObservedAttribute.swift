//
//  ObservedAttribute.swift
//  OpenAttributeGraph
//
//  Audited for 3.2.1
//  Status: Complete

public protocol ObservedAttribute: _AttributeBody {
    mutating func destroy()
}

extension ObservedAttribute {
    public static func _destroySelf(_ pointer: UnsafeMutableRawPointer) {
        pointer.assumingMemoryBound(to: Self.self).pointee.destroy()
    }

    public static var _hasDestroySelf: Bool {
        true
    }
}
