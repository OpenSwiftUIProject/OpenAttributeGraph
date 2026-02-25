//
//  GraphShims.swift
//  OpenAttributeGraphCompatibilityTests

#if OPENATTRIBUTEGRAPH
@_exported import OpenAttributeGraph
let compatibilityTestEnabled = false
#else
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
public let compatibilityTestEnabled = true
#endif
