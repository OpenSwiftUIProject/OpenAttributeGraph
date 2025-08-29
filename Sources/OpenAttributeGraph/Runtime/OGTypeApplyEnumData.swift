//
//  OAGTypeApplyEnumData.swift
//
//
//

// public import OpenAttributeGraphCxx

@discardableResult
public func withUnsafePointerToEnumCase<T>(
    of value: UnsafeMutablePointer<T>,
    do body: (Int, Any.Type, UnsafeRawPointer) -> ()
) -> Bool {
    // TODO: OAGTypeApplyEnumData
    return true
}

@discardableResult
public func withUnsafeMutablePointerToEnumCase<T>(
    of value: UnsafeMutablePointer<T>,
    do body: (Int, Any.Type, UnsafeMutableRawPointer) -> ()
) -> Bool {
    // TODO: OAGTypeApplyMutableEnumData
    return true
}
