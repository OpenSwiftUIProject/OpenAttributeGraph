//
//  DanceUIGraph.swift
//  OpenAttributeGraphShims

#if OPENATTRIBUTEGRAPH_DANCEUIGRAPH

@_exported public import DanceUIRuntime
@_exported public import DanceUIGraph

public typealias AnyAttribute = DGAttribute
public typealias AnyWeakAttribute = DGWeakAttribute
public typealias Graph = DGGraphRef
public typealias GraphContext = DGGraphContextRef
public typealias Metadata = DGTypeID
public typealias OAGAttributeInfo = DGAttributeInfo
public typealias OAGCachedValueOptions = DGGraphCachedValueOptions
public typealias OAGChangedValueFlags = DGChangedValueFlags
public typealias OAGInputOptions = DGInputOptions
public typealias OAGValue = DGGraphValue
public typealias OAGValueOptions = DGValueOptions
public typealias SearchOptions = DGSearchOptions
public typealias Subgraph = DGSubgraphRef
public typealias TupleType = DGTupleType
public typealias UnsafeMutableTuple = DGUnsafeMutableTuple
public typealias UnsafeTuple = DGUnsafeTuple
public typealias UniqueID = DGUniqueID
public typealias ValueState = DGValueState
public typealias _AttributeType = _DGAttributeType
public typealias _AttributeVTable = _DGAttributeVTable
public typealias _OAGClosureStorage = DGClosureStorage

extension AnyAttribute {
    public typealias Flags = DGAttributeFlags
}

extension Graph {
    public static func resetProfile() {
        reset()
    }

    public func resetProfile() {
        reset()
    }
}

extension Subgraph {
    public typealias Flags = AnyAttribute.Flags
    public typealias ChildFlags = AnyAttribute.Flags
}

public let attributeGraphVendor = AttributeGraphVendor.danceUIGraph

#endif
