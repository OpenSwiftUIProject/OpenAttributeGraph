//
//  GraphShims.swift
//  OpenAttributeGraphCompatibilityTests

#if OPENATTRIBUTEGRAPH_COMPATIBILITY_TEST
@_exported public import AttributeGraph
public typealias OAGAttributeInfo = AGAttributeInfo
public typealias OAGCachedValueOptions = AGCachedValueOptions
public typealias OAGChangedValueFlags = AGChangedValueFlags
public typealias OAGInputOptions = AGInputOptions
public typealias OAGValue = AGValue
public typealias OAGValueOptions = AGValueOptions
public let compatibilityTestEnabled = true
public let swiftToolchainSupported = true
#else
@_exported import OpenAttributeGraph
let compatibilityTestEnabled = false
#if OPENATTRIBUTEGRAPH_SWIFT_TOOLCHAIN_SUPPORTED
public let swiftToolchainSupported = true
#else
public let swiftToolchainSupported = false
#endif
#endif
