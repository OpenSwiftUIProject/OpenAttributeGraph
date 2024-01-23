//
//  OGTypeID.swift
//  OpenGraph
//
//  Created by Kyle on 2024/1/9.
//  Lastest Version: iOS 15.5
//  Status: WIP

import _OpenGraph

#if canImport(ObjectiveC)
@_silgen_name("OGTypeDescription")
public func OGTypeDescription(
    _ type: OGTypeID
) -> CFString
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

extension OGTypeID: CustomStringConvertible {
    public init(_ type: Any.Type) {
        self.init(rawValue: unsafeBitCast(type, to: UnsafePointer<OGSwiftMetadata>.self))
    }
    
    public var type: Any.Type {
        unsafeBitCast(rawValue, to: Any.Type.self)
    }
    
    public var description: String {
        #if canImport(ObjectiveC)
        OGTypeDescription(self) as String
        #else
        fatalError("Unimplemented")
        #endif
    }
    
    public func forEachField(
        do body: (UnsafePointer<Int8>, Int, Any.Type) -> Void
    ) {
        OGTypeApplyFields(type, body: body)
    }
    
    public func forEachField(
        options: OGTypeApplyOptions,
        do body: (UnsafePointer<Int8>, Int, Any.Type) -> Bool
    ) -> Bool {
        OGTypeApplyFields2(type, options: options, body: body)
    }
}
