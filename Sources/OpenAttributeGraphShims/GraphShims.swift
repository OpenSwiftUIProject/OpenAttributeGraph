//
//  GraphShims.swift
//  OpenAttributeGraphShims

#if OPENATTRIBUTEGRAPH_ATTRIBUTEGRAPH
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
public let attributeGraphEnabled = true
#else
@_exported import OpenAttributeGraph

public let attributeGraphEnabled = false
#endif
