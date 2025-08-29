//
//  GraphShims.swift
//  OpenAttributeGraphShims

#if OPENATTRIBUTEGRAPH_ATTRIBUTEGRAPH
@_exported public import AttributeGraph
public typealias OAGAttributeInfo = AGAttributeInfo
public typealias OAGCachedValueOptions = AGCachedValueOptions
public typealias OAGChangedValueFlags = AGChangedValueFlags
public typealias OAGInputOptions = AGInputOptions
public typealias OAGUniqueID = AGUniqueID
public typealias OAGValue = AGValue
public typealias OAGValueOptions = AGValueOptions
public let attributeGraphEnabled = true
public let swiftToolchainSupported = true
#else
@_exported import OpenAttributeGraph
public let attributeGraphEnabled = false
#if OPENATTRIBUTEGRAPH_SWIFT_TOOLCHAIN_SUPPORTED
public let swiftToolchainSupported = true
#else
public let swiftToolchainSupported = false
#endif
#endif
