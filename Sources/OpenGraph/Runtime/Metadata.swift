//
//  Metadata.swift
//  OpenGraph
//
//  Audited for RELEASE_2021
//  Status: WIP

public import OpenGraph_SPI
#if canImport(ObjectiveC)
public import Foundation
#endif

@_silgen_name("OGTypeApplyFields")
public func OGTypeApplyFields(
    _ type: Any.Type,
    body: (UnsafePointer<Int8>, Int, Any.Type) -> Void
)

@_silgen_name("OGTypeApplyFields2")
public func OGTypeApplyFields2(
    _ type: Any.Type,
    options: OGTypeApplyOptions,
    body: (UnsafePointer<Int8>, Int, Any.Type) -> Bool
) -> Bool

extension Metadata: Swift.Hashable, Swift.CustomStringConvertible {
    @inlinable
    @inline(__always)
    public init(_ type: any Any.Type) {
        self.init(rawValue: unsafeBitCast(type, to: UnsafePointer<_Metadata>.self))
    }
    
    @inlinable
    @inline(__always)
    public var type: any Any.Type {
        unsafeBitCast(rawValue, to: Any.Type.self)
    }
    
    @inlinable
    @inline(__always)
    public var description: String {
        #if canImport(ObjectiveC)
        __OGTypeDescription(self).takeUnretainedValue() as NSString as String
        #else
        fatalError("Unimplemented")
        #endif
    }
    
    @inlinable
    @inline(__always)
    /* public */func forEachField(
        do body: (UnsafePointer<Int8>, Int, Any.Type) -> Void
    ) {
        OGTypeApplyFields(type, body: body)
    }
    
    @inlinable
    @inline(__always)
    public func forEachField(
        options: OGTypeApplyOptions,
        do body: (UnsafePointer<Int8>, Int, Any.Type) -> Bool
    ) -> Bool {
        OGTypeApplyFields2(type, options: options, body: body)
    }
}
