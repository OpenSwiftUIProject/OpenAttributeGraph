//
//  DanceUIGraph.swift
//  OpenAttributeGraphShims

#if OPENATTRIBUTEGRAPH_DANCEUIGRAPH

// FIXME: Runtime crash to be fixed in OpenSwiftUI

@_exported public import DanceUIRuntime
@_exported public import DanceUIGraph

public typealias ComparisonMode = DGComparisonMode
public typealias GraphContext = DGGraphContextRef
public typealias Metadata = DGTypeID
public typealias OAGAttributeInfo = DGAttributeInfo
public typealias OAGCachedValueOptions = DGGraphCachedValueOptions
public typealias OAGChangedValueFlags = DGChangedValueFlags
public typealias OAGInputOptions = DGInputOptions
public typealias OAGValue = DGGraphValue
public typealias OAGValueOptions = DGInputOptions
public typealias OAGWeakValue = DGGraphWeakValue
public typealias ObservedAttribute = DanceUIGraph.ObservedAttribute
public typealias PointerOffset<Base, Member> = DanceUIGraph.PointerOffset<Base, Member>
public typealias SearchOptions = DGSearchOptions
public typealias TupleType = DGTupleType
public typealias UnsafeMutableTuple = DGUnsafeMutableTuple
public typealias UnsafeTuple = DGUnsafeTuple
public typealias UniqueID = UInt
public typealias ValueState = DGValueState
public typealias _AttributeBody = DanceUIGraph._AttributeBody
public typealias _AttributeType = _DGAttributeType
public typealias _AttributeVTable = _DGAttributeVTable
public typealias _OAGClosureStorage = DGClosureStorage
public typealias DescriptionOption = DanceUIGraphDescriptionOption
public typealias Signature = UnsafePointer<DanceUIGraphTypeSignature>
public typealias AttributeUpdateBlock = () -> (UnsafeMutableRawPointer, AnyAttribute) -> Void

public typealias OAGAttributeFlags = DGAttributeFlags

@_silgen_name("OAGDanceUIGraphGetContext")
private func OAGDGGraphGetContext(_ graph: DGGraphRef) -> UnsafeMutableRawPointer?

@_silgen_name("OAGDanceUIGraphSetContext")
private func OAGDGGraphSetContext(_ graph: DGGraphRef, _ context: UnsafeMutableRawPointer?)

@_silgen_name("OAGDanceUIGraphGetCurrentAttribute")
private func OAGDGGraphGetCurrentAttribute() -> DGAttribute

@_silgen_name("OAGDanceUIGraphCurrentAttributeWasModified")
private func OAGDGGraphCurrentAttributeWasModified() -> Bool

@_silgen_name("OAGDanceUIGraphCurrentAttributeUpdatedReason")
private func OAGDGGraphCurrentAttributeUpdatedReason() -> DGAttribute

@_silgen_name("OAGDanceUIGraphClearUpdate")
private func OAGDGGraphClearUpdate() -> UnsafeRawPointer

@_silgen_name("OAGDanceUIGraphSetUpdate")
private func OAGDGGraphSetUpdate(_ oldUpdate: UnsafeRawPointer)

@_silgen_name("OAGDanceUIGraphCreateAttribute")
private func OAGDGGraphCreateAttribute(
    _ typeIndex: DGGraphTypeIndex,
    _ body: UnsafeRawPointer,
    _ value: UnsafeRawPointer?
) -> DGAttribute

@_silgen_name("OAGDanceUIGraphGetValue")
private func OAGDGGraphGetValue(
    _ attribute: DGAttribute,
    _ options: DGInputOptions,
    _ valueType: Any.Type
) -> DGGraphValue

@_silgen_name("OAGDanceUIGraphSetValue")
@discardableResult
private func OAGDGGraphSetValue(
    _ attribute: DGAttribute,
    _ value: UnsafeRawPointer,
    _ type: Any.Type
) -> Bool

@_silgen_name("OAGDanceUIGraphGetInputValue")
private func OAGDGGraphGetInputValue(
    _ destinationAttribute: DGAttribute,
    _ inputAttribute: DGAttribute,
    _ options: DGInputOptions,
    _ valueType: Any.Type
) -> DGGraphValue

@_silgen_name("OAGDanceUIGraphGetOutputValue")
private func OAGDGGraphGetOutputValue<Value>() -> UnsafePointer<Value>?

@_silgen_name("OAGDanceUIGraphSetOutputValue")
private func OAGDGGraphSetOutputValue<Value>(_ valuePtr: UnsafePointer<Value>)

@_silgen_name("OAGDanceUIGraphWithUpdate")
private func OAGDGGraphWithUpdate(_ attribute: DGAttribute, _ body: () -> Void)

@_silgen_name("OAGDanceUIGraphCreateOffsetAttribute")
private func OAGDGGraphCreateOffsetAttribute(_ attribute: DGAttribute, _ offset: Int) -> DGAttribute

@_silgen_name("OAGDanceUIGraphCreateOffsetAttribute2")
private func OAGDGGraphCreateOffsetAttribute2(_ attribute: DGAttribute, _ offset: Int, _ size: Int) -> DGAttribute

@_silgen_name("OAGDanceUIGraphCreateIndirectAttribute")
private func OAGDGGraphCreateIndirectAttribute(_ attribute: DGAttribute) -> DGAttribute

@_silgen_name("OAGDanceUIGraphCreateIndirectAttribute2")
private func OAGDGGraphCreateIndirectAttribute2(_ attribute: DGAttribute, _ size: UInt32) -> DGAttribute

@_silgen_name("OAGDanceUIGraphGetIndirectAttribute")
private func OAGDGGraphGetIndirectAttribute(_ attribute: DGAttribute) -> DGAttribute

@_silgen_name("OAGDanceUIGraphSetIndirectAttribute")
private func OAGDGGraphSetIndirectAttribute(_ attribute: DGAttribute, _ source: DGAttribute)

@_silgen_name("OAGDanceUIGraphGetIndirectDependency")
private func OAGDGGraphGetIndirectDependency(_ attribute: DGAttribute) -> DGAttribute

@_silgen_name("OAGDanceUIGraphSetIndirectDependency")
private func OAGDGGraphSetIndirectDependency(_ attribute: DGAttribute, _ dependency: DGAttribute)

@_silgen_name("OAGDanceUIGraphCreateWeakAttribute")
private func OAGDGGraphCreateWeakAttribute(_ attribute: DGAttribute) -> DGWeakAttribute

@_silgen_name("OAGDanceUIGraphWeakAttributeGetAttribute")
private func OAGDGGraphWeakAttributeGetAttribute(_ weakAttribute: DGWeakAttribute) -> DGAttribute

@_silgen_name("OAGDanceUIGraphGetWeakValue")
private func OAGDGGraphGetWeakValue(
    _ weakAttribute: DGWeakAttribute,
    _ options: DGInputOptions,
    _ valueType: Any.Type
) -> DGGraphWeakValue

@_silgen_name("OAGDanceUIGraphGetAttributeInfo")
private func OAGDGGraphGetAttributeInfo(_ attribute: DGAttribute) -> DGAttributeInfo

@_silgen_name("OAGDanceUIGraphMutateAttribute")
private func OAGDGGraphMutateAttribute(
    _ attribute: DGAttribute,
    _ type: Any.Type,
    _ invalidate: Bool,
    _ body: (UnsafeMutableRawPointer) -> Void
)

@_silgen_name("OAGDanceUIGraphVerifyType")
private func OAGDGGraphVerifyType(_ attribute: DGAttribute, _ type: Any.Type)

@_silgen_name("OAGDanceUIGraphAddInput")
private func OAGDGGraphAddInput(_ toAttribute: DGAttribute, _ fromAttribute: DGAttribute, _ options: DGInputOptions)

@_silgen_name("OAGDanceUIGraphInvalidateAllValues")
private func OAGDGGraphInvalidateAllValues(_ graph: DGGraphRef)

@_silgen_name("OAGDanceUIGraphInvalidateValue")
private func OAGDGGraphInvalidateValue(_ attribute: DGAttribute)

@_silgen_name("OAGDanceUIGraphHasValue")
private func OAGDGGraphHasValue(_ attribute: DGAttribute) -> Bool

@_silgen_name("OAGDanceUIGraphUpdateValue")
private func OAGDGGraphUpdateValue(_ attribute: DGAttribute)

@_silgen_name("OAGDanceUIGraphGetValueState")
private func OAGDGGraphGetValueState(_ attribute: DGAttribute) -> DGValueState

@_silgen_name("OAGDanceUIGraphSearch")
private func OAGDGGraphSearch(
    attribute: DGAttribute,
    options: DGSearchOptions,
    body: (DGAttribute) -> Bool
) -> Bool

@_silgen_name("OAGDanceUIGraphGetFlags")
private func OAGDGGraphGetFlags(_ attribute: DGAttribute) -> DGAttributeFlags

@_silgen_name("OAGDanceUIGraphSetFlags")
private func OAGDGGraphSetFlags(_ attribute: DGAttribute, _ flags: DGAttributeFlags)

@_silgen_name("OAGDanceUIGraphReadCachedAttribute")
private func OAGDGGraphReadCachedAttribute(
    _ hashValue: Int,
    _ selfType: Any.Type,
    _ attributeBody: UnsafeRawPointer,
    _ valueType: Any.Type,
    _ valueOptions: DGGraphCachedValueOptions,
    _ attribute: DGAttribute,
    _ flags: UnsafeMutablePointer<DGChangedValueFlags>,
    _ body: (DGGraphContextRef) -> DGGraphTypeIndex
) -> UnsafeRawPointer

@_silgen_name("OAGDanceUIGraphReadCachedAttributeIfExists")
private func OAGDGGraphReadCachedAttributeIfExists(
    _ hashValue: Int,
    _ selfType: Any.Type,
    _ attributeBody: UnsafeRawPointer,
    _ valueType: Any.Type,
    _ valueOptions: DGGraphCachedValueOptions,
    _ attribute: DGAttribute,
    _ flags: UnsafeMutablePointer<DGChangedValueFlags>
) -> UnsafeRawPointer?

@_silgen_name("OAGDanceUISubgraphSetCurrent")
private func OAGDGSubgraphSetCurrent(_ subgraph: DGSubgraphRef?)

@_silgen_name("OAGDanceUISubgraphGetCurrent")
private func OAGDGSubgraphGetCurrent() -> DGSubgraphRef?

@_silgen_name("OAGDanceUISubgraphGetCurrentGraphContext")
private func OAGDGSubgraphGetCurrentGraphContext() -> DGGraphContextRef?

@_silgen_name("OAGDanceUISubgraphApply")
private func OAGDGSubgraphApply(_ subgraph: DGSubgraphRef, _ flags: DGAttributeFlags, _ body: (DGAttribute) -> Void)

@_silgen_name("OAGDanceUISubgraphIntersects")
private func OAGDGSubgraphIntersects(_ subgraph: DGSubgraphRef, _ flags: DGAttributeFlags) -> Bool

// MARK: - Graph

public final class Graph: Hashable {
    let base: DGGraphRef

    public init() {
        base = DGGraphCreate()
    }

    public init(shared graph: Graph) {
        base = DGGraphCreateShared(graph.base)
    }

    init(_ base: DGGraphRef) {
        self.base = base
    }

    public typealias CounterQueryType = DGGraphQueryType

    public struct TraceOptions: OptionSet, Sendable {
        public let rawValue: UInt32

        public init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }

    public static func == (lhs: Graph, rhs: Graph) -> Bool {
        lhs.base === rhs.base
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(base))
    }

    public static var current: Graph {
        AnyAttribute.current!.graph
    }

    public var context: UnsafeRawPointer? {
        get { OAGDGGraphGetContext(base).map(UnsafeRawPointer.init) }
        set { OAGDGGraphSetContext(base, newValue.map(UnsafeMutableRawPointer.init(mutating:))) }
    }

    public static func typeIndex(
        ctx: GraphContext,
        body: _AttributeBody.Type,
        valueType: Metadata,
        flags: _AttributeType.Flags,
        update: AttributeUpdateBlock
    ) -> DGGraphTypeIndex {
        DGGraphRef.typeIndex(
            ctx: ctx,
            body: body,
            valueType: valueType,
            flags: flags
        ) {
            let update = update()
            return { pointer, attribute in
                update(pointer, AnyAttribute(attribute))
            }
        }
    }

    public static func withoutUpdate<Value>(_ body: () -> Value) -> Value {
        DGGraphRef.withoutUpdate(body)
    }

    public func withoutSubgraphInvalidation<Value>(_ body: () -> Value) -> Value {
        let previousDeferring = DGGraphBeginDeferringSubgraphInvalidation(base)
        defer {
            DGGraphEndDeferringSubgraphInvalidation(base, previousDeferring: previousDeferring)
        }
        return body()
    }

    public func withDeadline<Value>(_: UInt64, _: () -> Value) -> Value {
        fatalError("OAGDanceUIGraph deadline-scoped updates are not available through OpenAttributeGraphShims")
    }

    public func onInvalidation(_ callback: @escaping (AnyAttribute) -> Void) {
        base.onInvalidation { callback(AnyAttribute($0)) }
    }

    public func onUpdate(_ callback: @escaping () -> Void) {
        base.onUpdate(callback)
    }

    public func withMainThreadHandler(_ handler: (() -> Void) -> Void, do body: () -> Void) {
        base.withMainThreadHandler(handler, do: body)
    }

    public func invalidateAllValues() {
        OAGDGGraphInvalidateAllValues(base)
    }

    public func invalidate() {
        base.invalidate()
    }

    public func setNeedsUpdate() {
        DGGraphSetNeedsUpdate(base)
    }

    public func counter(for query: CounterQueryType) -> UInt64 {
        switch query {
        case []:
            0
        case .transactionCounter:
            UInt64(base.transactionCounter)
        case .updateCounter:
            UInt64(base.updateCounter)
        case .changeCounter:
            0
        case .internTypes:
            UInt64(base.internTypes)
        case .uniqueID:
            UInt64(base.graphIdentity)
        case .isUpdating:
            base.isUpdating ? 1 : 0
        case .hasCurrentUpdate:
            base.hasCurrentUpdate ? 1 : 0
        case .contextNeedsUpdate, .graphNeedsUpdate:
            0
        case .mainUpdates:
            UInt64(base.mainUpdates)
        default:
            0
        }
    }

    public var mainUpdates: Int {
        numericCast(counter(for: .mainThreadUpdates))
    }

    public static func outputValue<Value>() -> UnsafePointer<Value>? {
        OAGDGGraphGetOutputValue()
    }

    public static func setOutputValue<Value>(_ value: UnsafePointer<Value>) {
        OAGDGGraphSetOutputValue(value)
    }

    public static func anyInputsChanged(excluding excludedInputs: [AnyAttribute]) -> Bool {
        DGGraphRef.anyInputsChanged(excludedInputs.map(\.base))
    }

    public static func resetProfile() {
        DGGraphRef.reset()
    }

    public static func startProfiling() {
        DGGraphRef.startProfiling()
    }

    public static func stopProfiling() {
        DGGraphRef.stopProfiling()
    }

    public func resetProfile() {
        base.reset()
    }

    public static func startTracing(_ graph: Graph?, options _: TraceOptions?) {
        graph?.base.startProfiling()
    }

    public static func stopTracing(_ graph: Graph?) {
        graph?.base.stopProfiling()
    }

    public func startProfiling() {
        base.startProfiling()
    }

    public func stopProfiling() {
        base.stopProfiling()
    }

    public func archiveJSON(name: String?) {
        if let name {
            name.withCString { base.archiveJSON(name: $0) }
        } else {
            let nilName: UnsafePointer<CChar>? = nil
            base.archiveJSON(name: nilName)
        }
    }

    public static func archiveJSON(name: UnsafePointer<CChar>?) {
        DGGraphRef.current.archiveJSON(name: name)
    }

    public static var descriptionFormatDictionary: CFString {
        DanceUIGraphDescriptionFormatKind.graphDictionary.rawValue as CFString
    }

    public static var descriptionFormatDot: CFString {
        DanceUIGraphDescriptionFormatKind.graphDot.rawValue as CFString
    }

    public static var descriptionAllGraphs: CFString {
        DescriptionOption.allGraphs.rawValue as CFString
    }

    public static func description(_ graph: Graph?, options: NSDictionary) -> Any? {
        var danceOptions: [DescriptionOption: Any] = [:]
        for (key, value) in options {
            guard let option = key as? DescriptionOption else {
                continue
            }
            danceOptions[option] = value
        }
        return DanceUIGraphDescription(graph?.base, danceOptions)
    }
}

public func === (lhs: Graph, rhs: Graph) -> Bool {
    lhs.base === rhs.base
}

public func !== (lhs: Graph, rhs: Graph) -> Bool {
    lhs.base !== rhs.base
}

extension Graph.CounterQueryType {
    public static var nodes: Self { [] }
    public static var transactions: Self { .transactionCounter }
    public static var updates: Self { .updateCounter }
    public static var changes: Self { .changeCounter }
    public static var contextID: Self { .internTypes }
    public static var graphID: Self { .uniqueID }
    public static var contextThreadUpdating: Self { .isUpdating }
    public static var threadUpdating: Self { .hasCurrentUpdate }
    public static var needsUpdate: Self { .graphNeedsUpdate }
    public static var mainThreadUpdates: Self { .mainUpdates }
    public static var createdNodes: Self { [] }
    public static var subgraphs: Self { Self(rawValue: 0) }
    public static var createdSubgraphs: Self { Self(rawValue: 0) }
}

// MARK: - Subgraph

public final class Subgraph: Hashable {
    public var base: DGSubgraphRef

    public init(_ base: DGSubgraphRef) {
        self.base = base
    }

    public init(graph: Graph) {
        base = DGSubgraphCreate(graph.base)
    }

    public init(graph: Graph, attribute: AnyAttribute) {
        base = DGSubgraphCreate2(graph.base, attribute.base)
    }

    public typealias Flags = AnyAttribute.Flags
    public typealias ChildFlags = AnyAttribute.Flags

    public static func == (lhs: Subgraph, rhs: Subgraph) -> Bool {
        lhs.base === rhs.base
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(base))
    }

    public static var current: Subgraph? {
        get { OAGDGSubgraphGetCurrent().map(Subgraph.init) }
        set { OAGDGSubgraphSetCurrent(newValue?.base) }
    }

    public static var currentGraphContext: GraphContext? {
        OAGDGSubgraphGetCurrentGraphContext()
    }

    public var graph: Graph {
        Graph(base.graph)
    }

    public var isValid: Bool {
        base.isValid
    }

    public func apply<Value>(_ body: () -> Value) -> Value {
        base.apply(body)
    }

    public func forEach(_ flags: Flags, _ callback: (AnyAttribute) -> Void) {
        OAGDGSubgraphApply(base, flags) { callback(AnyAttribute($0)) }
    }

    public func addChild(_ child: Subgraph) {
        base.add(child: child.base)
    }

    public func addChild(_ child: Subgraph, tag _: UInt8) {
        addChild(child)
    }

    public func removeChild(_ child: Subgraph) {
        base.remove(child: child.base)
    }

    @discardableResult
    public func addObserver(_ observer: @escaping () -> Void) -> Int {
        Int(base.add(observer: observer).rawValue)
    }

    public func removeObserver(_ observerID: Int) {
        base.remove(observer: DGUniqueID(rawValue: Int64(observerID)))
    }

    public func isAncestor(of other: Subgraph) -> Bool {
        base.isAncestor(other.base)
    }

    public func isDirty(flags: Flags) -> Bool {
        base.isDirty(UInt64(flags.rawValue))
    }

    public func update(flags: Flags) {
        base.update(flags)
    }

    public func intersects(flags: Flags) -> Bool {
        OAGDGSubgraphIntersects(base, flags)
    }

    public func invalidate() {
        base.invalidate()
    }

    public var index: UInt32 {
        get { 0 }
        set { DGSubgraphSetIndex(base, newValue) }
    }

    public static var shouldRecordTree: Bool {
        get { DGSubgraphRef.shouldRecordTree }
        set { DGSubgraphRef.shouldRecordTree = newValue }
    }

    public static func setShouldRecordTree(_ flag: Bool = true) {
        shouldRecordTree = flag
    }

    public static func beginTreeElement<Value>(value: Attribute<Value>, flags: UInt32) {
        DGSubgraphRef.beginTreeElement(value: DanceUIGraph.Attribute<Value>(identifier: value.identifier.base), flags: flags)
    }

    public static func addTreeValue<Value>(_ attribute: Attribute<Value>, forKey key: UnsafePointer<CChar>, flags: UInt32) {
        DGSubgraphRef.addTreeValue(DanceUIGraph.Attribute<Value>(identifier: attribute.identifier.base), forKey: key, flags: flags)
    }

    public static func endTreeElement<Value>(value: Attribute<Value>) {
        DGSubgraphRef.endTreeElement(value: DanceUIGraph.Attribute<Value>(identifier: value.identifier.base))
    }
}

public func === (lhs: Subgraph, rhs: Subgraph) -> Bool {
    lhs == rhs
}

public func !== (lhs: Subgraph, rhs: Subgraph) -> Bool {
    !(lhs == rhs)
}

// MARK: - Attributes

@frozen
public struct AnyAttribute: RawRepresentable, Hashable, CustomStringConvertible, CustomDebugStringConvertible {
    public typealias RawValue = UInt32
    public typealias Flags = OAGAttributeFlags

    public var base: DGAttribute

    public init(rawValue: UInt32) {
        base = DGAttribute(rawValue: rawValue)
    }

    public init(_ base: DGAttribute) {
        self.base = base
    }

    public init<Value>(_ attribute: Attribute<Value>) {
        base = attribute.identifier.base
    }

    public var rawValue: UInt32 {
        base.rawValue
    }

    public static var `nil`: AnyAttribute {
        AnyAttribute(DGAttribute.nil)
    }

    public static var current: AnyAttribute? {
        let current = OAGDGGraphGetCurrentAttribute()
        return current == .nil ? nil : AnyAttribute(current)
    }

    public static var currentWasModified: Bool {
        OAGDGGraphCurrentAttributeWasModified()
    }

    public var graph: Graph {
        Graph(base.graph)
    }

    public var subgraph: Subgraph {
        Subgraph(base.subgraph)
    }

    public var subgraph2: Subgraph? {
        base == .nil ? nil : subgraph
    }

    public var source: AnyAttribute {
        get { AnyAttribute(OAGDGGraphGetIndirectAttribute(base)) }
        nonmutating set { OAGDGGraphSetIndirectAttribute(base, newValue.base) }
    }

    public var indirectDependency: AnyAttribute? {
        get {
            let dependency = OAGDGGraphGetIndirectDependency(base)
            return dependency == .nil ? nil : AnyAttribute(dependency)
        }
        nonmutating set {
            OAGDGGraphSetIndirectDependency(base, newValue?.base ?? .nil)
        }
    }

    public var info: OAGAttributeInfo {
        OAGDGGraphGetAttributeInfo(base)
    }

    public var flags: Flags {
        get { OAGDGGraphGetFlags(base) }
        nonmutating set { OAGDGGraphSetFlags(base, newValue) }
    }

    public var hasValue: Bool {
        OAGDGGraphHasValue(base)
    }

    public func unsafeCast<Value>(to _: Value.Type) -> Attribute<Value> {
        Attribute<Value>(identifier: self)
    }

    public func unsafeOffset(at offset: Int) -> AnyAttribute {
        create(offset: offset)
    }

    public func create(offset: Int, size: UInt32 = 0) -> AnyAttribute {
        if size == 0 {
            AnyAttribute(OAGDGGraphCreateOffsetAttribute(base, offset))
        } else {
            AnyAttribute(OAGDGGraphCreateOffsetAttribute2(base, offset, Int(size)))
        }
    }

    public func createIndirect() -> AnyAttribute {
        AnyAttribute(OAGDGGraphCreateIndirectAttribute(base))
    }

    public func createIndirect(size: UInt64) -> AnyAttribute {
        AnyAttribute(OAGDGGraphCreateIndirectAttribute2(base, UInt32(size)))
    }

    public func updateValue() {
        OAGDGGraphUpdateValue(base)
    }

    public func prefetchValue() {
        updateValue()
    }

    public func invalidateValue() {
        OAGDGGraphInvalidateValue(base)
    }

    public var valueState: ValueState {
        OAGDGGraphGetValueState(base)
    }

    public func addInput(_ attribute: AnyAttribute, options: OAGInputOptions = [], token _: Int) {
        OAGDGGraphAddInput(base, attribute.base, options)
    }

    public func addInput<Value>(_ attribute: Attribute<Value>, options: OAGInputOptions = [], token: Int) {
        addInput(attribute.identifier, options: options, token: token)
    }

    public func setFlags(_ newFlags: Flags, mask: Flags) {
        flags = flags.subtracting(mask).union(newFlags.intersection(mask))
    }

    public func visitBody<Visitor>(_ visitor: inout Visitor) where Visitor: AttributeBodyVisitor {
        base.visitBody(&visitor)
    }

    public func mutateBody<Value>(as type: Value.Type, invalidating: Bool, _ body: (inout Value) -> Void) {
        OAGDGGraphMutateAttribute(base, type, invalidating) { value in
            body(&value.assumingMemoryBound(to: Value.self).pointee)
        }
    }

    public func breadthFirstSearch(options: SearchOptions = [], _ body: (AnyAttribute) -> Bool) -> Bool {
        OAGDGGraphSearch(attribute: base, options: options) { body(AnyAttribute($0)) }
    }

    public var _bodyType: Any.Type {
        base._bodyType.type
    }

    public var _bodyPointer: UnsafeRawPointer {
        info.body
    }

    public var valueType: Any.Type {
        base.valueType.type
    }

    public var description: String {
        "#\(rawValue)"
    }

    public var debugDescription: String {
        base.debugDescription
    }

    public static func == (lhs: AnyAttribute, rhs: AnyAttribute) -> Bool {
        lhs.base == rhs.base
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(base)
    }
}

@frozen
@propertyWrapper
@dynamicMemberLookup
public struct Attribute<Value>: Hashable, Equatable, CustomStringConvertible {
    public var identifier: AnyAttribute

    public init(identifier: AnyAttribute) {
        self.identifier = identifier
    }

    public init(_ attribute: Attribute<Value>) {
        self = attribute
    }

    public init(value: Value) {
        self = withUnsafePointer(to: value) { valuePointer in
            withUnsafePointer(to: External<Value>()) { bodyPointer in
                Attribute(body: bodyPointer, value: valuePointer, flags: .external) {
                    External<Value>._update
                }
            }
        }
    }

    public init(type _: Value.Type) {
        self = withUnsafePointer(to: External<Value>()) { bodyPointer in
            Attribute(body: bodyPointer, value: nil, flags: .external) {
                External<Value>._update
            }
        }
    }

    public init<Body: _AttributeBody>(
        body: UnsafePointer<Body>,
        value: UnsafePointer<Value>?,
        flags: _AttributeType.Flags = [],
        update: AttributeUpdateBlock
    ) {
        guard let context = Subgraph.currentGraphContext else {
            fatalError("attempting to create attribute with no subgraph: \(Value.self)")
        }
        let index = Graph.typeIndex(
            ctx: context,
            body: Body.self,
            valueType: Metadata(Value.self),
            flags: flags,
            update: update
        )
        identifier = AnyAttribute(OAGDGGraphCreateAttribute(index, body, value))
    }

    public var wrappedValue: Value {
        unsafeAddress {
            OAGDGGraphGetValue(identifier.base, [], Value.self)
                .value_ptr
                .assumingMemoryBound(to: Value.self)
        }
        nonmutating set { _ = setValue(newValue) }
    }

    public var projectedValue: Attribute<Value> {
        get { self }
        set { self = newValue }
    }

    public subscript<Member>(dynamicMember keyPath: KeyPath<Value, Member>) -> Attribute<Member> {
        self[keyPath: keyPath]
    }

    public subscript<Member>(keyPath keyPath: KeyPath<Value, Member>) -> Attribute<Member> {
        if let offset = MemoryLayout<Value>.offset(of: keyPath) {
            return unsafeOffset(at: offset, as: Member.self)
        } else {
            return Attribute<Member>(Focus(root: self, keyPath: keyPath))
        }
    }

    public subscript<Member>(offset body: (inout Value) -> PointerOffset<Value, Member>) -> Attribute<Member> {
        unsafeOffset(at: PointerOffset.offset(body).byteOffset, as: Member.self)
    }

    public func unsafeCast<OtherValue>(to _: OtherValue.Type) -> Attribute<OtherValue> {
        Attribute<OtherValue>(identifier: identifier)
    }

    public func unsafeOffset<Member>(at offset: Int, as _: Member.Type) -> Attribute<Member> {
        Attribute<Member>(
            identifier: identifier.create(
                offset: offset,
                size: numericCast(MemoryLayout<Member>.size)
            )
        )
    }

    public func applying<Member>(offset: PointerOffset<Value, Member>) -> Attribute<Member> {
        unsafeOffset(at: offset.byteOffset, as: Member.self)
    }

    public func visitBody<Body: AttributeBodyVisitor>(_ visitor: inout Body) {
        identifier.visitBody(&visitor)
    }

    public func mutateBody<V>(as type: V.Type, invalidating: Bool, _ body: (inout V) -> Void) {
        identifier.mutateBody(as: type, invalidating: invalidating, body)
    }

    public func breadthFirstSearch(options: SearchOptions = [], _ body: (AnyAttribute) -> Bool) -> Bool {
        identifier.breadthFirstSearch(options: options, body)
    }

    public var graph: Graph {
        identifier.graph
    }

    public var subgraph: Subgraph {
        identifier.subgraph
    }

    public var value: Value {
        unsafeAddress {
            OAGDGGraphGetValue(identifier.base, [], Value.self)
                .value_ptr
                .assumingMemoryBound(to: Value.self)
        }
        nonmutating set { _ = setValue(newValue) }
    }

    public var valueState: ValueState {
        identifier.valueState
    }

    public func valueAndFlags(options: OAGValueOptions = []) -> (value: Value, flags: OAGChangedValueFlags) {
        let value = OAGDGGraphGetValue(identifier.base, options, Value.self)
        return (
            value.value_ptr.assumingMemoryBound(to: Value.self).pointee,
            value.changed_value_flags
        )
    }

    public func changedValue(options: OAGValueOptions = []) -> (value: Value, changed: Bool) {
        let result = valueAndFlags(options: options)
        return (result.value, result.flags.contains(.changed))
    }

    public func setValue(_ value: Value) -> Bool {
        withUnsafePointer(to: value) { valuePointer in
            OAGDGGraphSetValue(identifier.base, valuePointer, Value.self)
        }
    }

    public var hasValue: Bool {
        identifier.hasValue
    }

    public func updateValue() {
        identifier.updateValue()
    }

    public func prefetchValue() {
        identifier.prefetchValue()
    }

    public func invalidateValue() {
        identifier.invalidateValue()
    }

    public func validate() {
        OAGDGGraphVerifyType(identifier.base, Value.self)
    }

    public func addInput(_ attribute: AnyAttribute, options: OAGInputOptions = [], token: Int) {
        identifier.addInput(attribute, options: options, token: token)
    }

    public func addInput<V>(_ attribute: Attribute<V>, options: OAGInputOptions = [], token: Int) {
        identifier.addInput(attribute.identifier, options: options, token: token)
    }

    public typealias Flags = AnyAttribute.Flags

    public var flags: Flags {
        get { identifier.flags }
        nonmutating set { identifier.flags = newValue }
    }

    public func setFlags(_ newFlags: Flags, mask: Flags) {
        identifier.setFlags(newFlags, mask: mask)
    }

    public var description: String {
        identifier.description
    }
}

extension Attribute {
    public init<R: Rule>(_ rule: R) where R.Value == Value {
        self = withUnsafePointer(to: rule) { pointer in
            Attribute(body: pointer, value: nil) { R._update }
        }
    }

    public init<R: StatefulRule>(_ rule: R) where R.Value == Value {
        self = withUnsafePointer(to: rule) { pointer in
            Attribute(body: pointer, value: nil) { R._update }
        }
    }
}

// MARK: - Weak and optional attributes

@frozen
public struct AnyWeakAttribute: Hashable, CustomStringConvertible, CustomDebugStringConvertible {
    public struct Details: Hashable {
        public var identifier: AnyAttribute
        public var seed: UInt32

        public init(identifier: AnyAttribute, seed: UInt32) {
            self.identifier = identifier
            self.seed = seed
        }
    }

    public var base: DGWeakAttribute

    public init(_ attribute: AnyAttribute?) {
        base = OAGDGGraphCreateWeakAttribute(attribute?.base ?? .nil)
    }

    public init(_ attribute: AnyAttribute) {
        self.init(Optional(attribute))
    }

    public init(_details: Details) {
        base = OAGDGGraphCreateWeakAttribute(_details.identifier.base)
    }

    public init<Value>(_ weakAttribute: WeakAttribute<Value>) {
        base = weakAttribute.base.base
    }

    public init(base: DGWeakAttribute) {
        self.base = base
    }

    public var _details: Details {
        Details(identifier: attribute ?? .nil, seed: base.subgraph_id)
    }

    public var details: Details {
        _details
    }

    public var attribute: AnyAttribute? {
        get {
            let attribute = OAGDGGraphWeakAttributeGetAttribute(base)
            return attribute == .nil ? nil : AnyAttribute(attribute)
        }
        set {
            base = OAGDGGraphCreateWeakAttribute(newValue?.base ?? .nil)
        }
    }

    public func unsafeCast<Value>(to _: Value.Type) -> WeakAttribute<Value> {
        WeakAttribute(base: self)
    }

    public static func == (lhs: AnyWeakAttribute, rhs: AnyWeakAttribute) -> Bool {
        lhs._details == rhs._details
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(_details)
    }

    public var description: String {
        attribute?.description ?? "nil"
    }

    public var debugDescription: String {
        base.debugDescription
    }
}

@frozen
@propertyWrapper
@dynamicMemberLookup
public struct WeakAttribute<Value>: Hashable, CustomStringConvertible {
    public var base: AnyWeakAttribute

    public init(base: AnyWeakAttribute) {
        self.base = base
    }

    public init() {
        base = AnyWeakAttribute(nil)
    }

    public init(_ attribute: Attribute<Value>) {
        base = AnyWeakAttribute(attribute.identifier)
    }

    public init(_ attribute: Attribute<Value>?) {
        base = AnyWeakAttribute(attribute?.identifier)
    }

    public var wrappedValue: Value? {
        OAGDGGraphGetWeakValue(base.base, [], Value.self)
            .value_ptr?
            .assumingMemoryBound(to: Value.self)
            .pointee
    }

    public var projectedValue: Attribute<Value>? {
        get { attribute }
        set { attribute = newValue }
        _modify { yield &attribute }
    }

    public subscript<Member>(dynamicMember keyPath: KeyPath<Value, Member>) -> Attribute<Member>? {
        attribute?[keyPath: keyPath]
    }

    public var attribute: Attribute<Value>? {
        get { base.attribute?.unsafeCast(to: Value.self) }
        set { base.attribute = newValue?.identifier }
    }

    public var value: Value? {
        wrappedValue
    }

    public func changedValue(options: OAGValueOptions = []) -> (value: Value, changed: Bool)? {
        let value = OAGDGGraphGetWeakValue(base.base, options, Value.self)
        guard let pointer = value.value_ptr else {
            return nil
        }
        return (
            pointer.assumingMemoryBound(to: Value.self).pointee,
            value.changed_value_flags.contains(.changed)
        )
    }

    public var description: String {
        base.description
    }
}

@frozen
public struct AnyOptionalAttribute: Hashable, CustomStringConvertible, CustomDebugStringConvertible {
    public var identifier: AnyAttribute

    public init() {
        identifier = .nil
    }

    public init(_ attribute: AnyAttribute) {
        identifier = attribute
    }

    public init(_ attribute: AnyAttribute?) {
        identifier = attribute ?? .nil
    }

    public init(_ weakAttribute: AnyWeakAttribute) {
        identifier = weakAttribute.attribute ?? .nil
    }

    public init<Value>(_ attribute: OptionalAttribute<Value>) {
        self = attribute.base
    }

    public static var current: AnyOptionalAttribute {
        AnyOptionalAttribute(AnyAttribute(OAGDGGraphGetCurrentAttribute()))
    }

    public var attribute: AnyAttribute? {
        get { identifier == .nil ? nil : identifier }
        set { identifier = newValue ?? .nil }
    }

    public func map<Value>(_ body: (AnyAttribute) -> Value) -> Value? {
        if let attribute {
            body(attribute)
        } else {
            nil
        }
    }

    public func unsafeCast<Value>(to _: Value.Type) -> OptionalAttribute<Value> {
        OptionalAttribute(base: self)
    }

    public var description: String {
        attribute?.description ?? "nil"
    }

    public var debugDescription: String {
        description
    }
}

@frozen
@propertyWrapper
@dynamicMemberLookup
public struct OptionalAttribute<Value>: Hashable, CustomStringConvertible {
    public var base: AnyOptionalAttribute

    public init() {
        base = AnyOptionalAttribute()
    }

    public init(base: AnyOptionalAttribute) {
        self.base = base
    }

    public init(_ attribute: Attribute<Value>) {
        base = AnyOptionalAttribute(attribute.identifier)
    }

    public init(_ attribute: Attribute<Value>?) {
        base = AnyOptionalAttribute(attribute?.identifier)
    }

    public init(_ weakAttribute: WeakAttribute<Value>) {
        base = AnyOptionalAttribute(weakAttribute.base)
    }

    public var attribute: Attribute<Value>? {
        get { base.attribute?.unsafeCast(to: Value.self) }
        set { base.attribute = newValue?.identifier }
    }

    public var value: Value? {
        attribute?.value
    }

    public func changedValue(options: OAGValueOptions = []) -> (value: Value, changed: Bool)? {
        attribute?.changedValue(options: options)
    }

    public func map<OtherValue>(_ body: (Attribute<Value>) -> OtherValue) -> OtherValue? {
        if let attribute {
            body(attribute)
        } else {
            nil
        }
    }

    public var wrappedValue: Value? {
        value
    }

    public var projectedValue: Attribute<Value>? {
        get { attribute }
        set { attribute = newValue }
        _modify { yield &attribute }
    }

    public subscript<Member>(dynamicMember keyPath: KeyPath<Value, Member>) -> Attribute<Member>? {
        attribute?[keyPath: keyPath]
    }

    public var description: String {
        attribute?.description ?? "nil"
    }
}

// MARK: - Rule contexts

@frozen
public struct AnyRuleContext: Equatable {
    public var attribute: AnyAttribute

    public static var current: AnyRuleContext {
        AnyRuleContext(attribute: AnyAttribute.current!)
    }

    public static var wasModified: Bool {
        AnyAttribute.currentWasModified
    }

    public static var updateReason: AnyAttribute? {
        let reason = OAGDGGraphCurrentAttributeUpdatedReason()
        return reason == .nil ? nil : AnyAttribute(reason)
    }

    public init(attribute: AnyAttribute) {
        self.attribute = attribute
    }

    public init(_ attribute: AnyAttribute) {
        self.attribute = attribute
    }

    public init(_ optionalAttribute: AnyOptionalAttribute) {
        attribute = optionalAttribute.identifier
    }

    public init<Value>(_ context: RuleContext<Value>) {
        attribute = context.attribute.identifier
    }

    public subscript<Value>(attribute: Attribute<Value>) -> Value {
        unsafeAddress {
            OAGDGGraphGetInputValue(self.attribute.base, attribute.identifier.base, [], Value.self)
                .value_ptr
                .assumingMemoryBound(to: Value.self)
        }
    }

    public subscript<Value>(weakAttribute: WeakAttribute<Value>) -> Value? {
        weakAttribute.attribute.map { self[$0] }
    }

    public subscript<Value>(optionalAttribute: OptionalAttribute<Value>) -> Value? {
        optionalAttribute.attribute.map { self[$0] }
    }

    public func valueAndFlags<Value>(
        of input: Attribute<Value>,
        options: OAGValueOptions = []
    ) -> (value: Value, flags: OAGChangedValueFlags) {
        let value = OAGDGGraphGetInputValue(attribute.base, input.identifier.base, options, Value.self)
        return (
            value.value_ptr.assumingMemoryBound(to: Value.self).pointee,
            value.changed_value_flags
        )
    }

    public func changedValue<Value>(of input: Attribute<Value>, options: OAGValueOptions = []) -> (value: Value, changed: Bool) {
        let result = valueAndFlags(of: input, options: options)
        return (result.value, result.flags.contains(.changed))
    }

    public func update(body: () -> Void) {
        OAGDGGraphWithUpdate(attribute.base, body)
    }

    public func unsafeCast<Value>(to _: Value.Type) -> RuleContext<Value> {
        RuleContext(attribute: Attribute(identifier: attribute))
    }
}

@frozen
public struct RuleContext<Value>: Equatable {
    public var attribute: Attribute<Value>

    public init(attribute: Attribute<Value>) {
        self.attribute = attribute
    }

    public subscript<OtherValue>(attribute: Attribute<OtherValue>) -> OtherValue {
        unsafeAddress {
            OAGDGGraphGetInputValue(self.attribute.identifier.base, attribute.identifier.base, [], OtherValue.self)
                .value_ptr
                .assumingMemoryBound(to: OtherValue.self)
        }
    }

    public subscript<OtherValue>(weakAttribute: WeakAttribute<OtherValue>) -> OtherValue? {
        weakAttribute.attribute.map { self[$0] }
    }

    public subscript<OtherValue>(optionalAttribute: OptionalAttribute<OtherValue>) -> OtherValue? {
        optionalAttribute.attribute.map { self[$0] }
    }

    public var value: Value {
        unsafeAddress { Graph.outputValue()! }
        nonmutating set {
            withUnsafePointer(to: newValue) { value in
                Graph.setOutputValue(value)
            }
        }
    }

    public var hasValue: Bool {
        let valuePointer: UnsafePointer<Value>? = Graph.outputValue()
        return valuePointer != nil
    }

    public func valueAndFlags<OtherValue>(
        of input: Attribute<OtherValue>,
        options: OAGValueOptions = []
    ) -> (value: OtherValue, flags: OAGChangedValueFlags) {
        let value = OAGDGGraphGetInputValue(attribute.identifier.base, input.identifier.base, options, OtherValue.self)
        return (
            value.value_ptr.assumingMemoryBound(to: OtherValue.self).pointee,
            value.changed_value_flags
        )
    }

    public func changedValue<OtherValue>(of input: Attribute<OtherValue>, options: OAGValueOptions = []) -> (value: OtherValue, changed: Bool) {
        let result = valueAndFlags(of: input, options: options)
        return (result.value, result.flags.contains(.changed))
    }

    public func update(body: () -> Void) {
        OAGDGGraphWithUpdate(attribute.identifier.base, body)
    }
}

// MARK: - Rules

public protocol Rule: _AttributeBody {
    associatedtype Value
    static var initialValue: Value? { get }
    var value: Value { get }
}

extension Rule {
    public static var initialValue: Value? { nil }

    public static func _update(_ pointer: UnsafeMutableRawPointer, attribute _: AnyAttribute) {
        let rule = pointer.assumingMemoryBound(to: Self.self)
        let value = rule.pointee.value
        withUnsafePointer(to: value) { value in
            Graph.setOutputValue(value)
        }
    }

    public static func _updateDefault(_: UnsafeMutableRawPointer) {
        guard let initialValue else {
            return
        }
        withUnsafePointer(to: initialValue) { value in
            Graph.setOutputValue(value)
        }
    }

    public var attribute: Attribute<Value> {
        Attribute<Value>(identifier: AnyAttribute.current!)
    }

    public var context: RuleContext<Value> {
        RuleContext<Value>(attribute: attribute)
    }

    public var optionalValue: Value? {
        (Graph.outputValue() as UnsafePointer<Value>?)?.pointee
    }
}

extension Rule where Self: Hashable {
    public func cachedValue(options: OAGCachedValueOptions = [], owner: AnyAttribute?) -> Value {
        cachedValue(options, owner: owner)
    }

    public func cachedValue(_ options: OAGCachedValueOptions = [], owner: AnyAttribute?) -> Value {
        withUnsafePointer(to: self) { pointer in
            var flags = OAGChangedValueFlags()
            let value = OAGDGGraphReadCachedAttribute(
                hashValue,
                Self.self,
                pointer,
                Value.self,
                options,
                owner?.base ?? .nil,
                &flags
            ) { context in
                Graph.typeIndex(
                    ctx: context,
                    body: Self.self,
                    valueType: Metadata(Value.self),
                    flags: Self.flags,
                    update: { Self._update }
                )
            }
            return value.assumingMemoryBound(to: Value.self).pointee
        }
    }

    public func cachedValueIfExists(options: OAGCachedValueOptions = [], owner: AnyAttribute?) -> Value? {
        cachedValueIfExists(options, owner: owner)
    }

    public func cachedValueIfExists(_ options: OAGCachedValueOptions = [], owner: AnyAttribute?) -> Value? {
        withUnsafePointer(to: self) { pointer in
            var flags = OAGChangedValueFlags()
            let value = OAGDGGraphReadCachedAttributeIfExists(
                hashValue,
                Self.self,
                pointer,
                Value.self,
                options,
                owner?.base ?? .nil,
                &flags
            )
            return value?.assumingMemoryBound(to: Value.self).pointee
        }
    }
}

public protocol StatefulRule: _AttributeBody {
    associatedtype Value
    static var initialValue: Value? { get }
    mutating func updateValue()
}

extension StatefulRule {
    public static var initialValue: Value? { nil }

    public static func _update(_ pointer: UnsafeMutableRawPointer, attribute _: AnyAttribute) {
        pointer.assumingMemoryBound(to: Self.self)
            .pointee
            .updateValue()
    }

    public static func _updateDefault(_: UnsafeMutableRawPointer) {
        guard let initialValue else {
            return
        }
        withUnsafePointer(to: initialValue) { value in
            Graph.setOutputValue(value)
        }
    }

    public var attribute: Attribute<Value> {
        Attribute<Value>(identifier: AnyAttribute.current!)
    }

    public var context: RuleContext<Value> {
        RuleContext<Value>(attribute: attribute)
    }

    public var value: Value {
        unsafeAddress { Graph.outputValue()! }
        nonmutating set { context.value = newValue }
    }

    public var hasValue: Bool {
        context.hasValue
    }

    public var optionalValue: Value? {
        (Graph.outputValue() as UnsafePointer<Value>?)?.pointee
    }
}

@frozen
public struct External<Value>: _AttributeBody, CustomStringConvertible {
    public init() {}

    public static func _update(_: UnsafeMutableRawPointer, attribute: AnyAttribute) {
        let value = Attribute<Value>(identifier: attribute).value
        withUnsafePointer(to: value) { value in
            Graph.setOutputValue(value)
        }
    }

    public static var flags: _AttributeType.Flags {
        .external
    }

    public var description: String {
        "External<\(Value.self)>"
    }
}

@frozen
public struct Focus<Root, Value>: Rule {
    public var root: Attribute<Root>
    public var keyPath: KeyPath<Root, Value>

    public init(root: Attribute<Root>, keyPath: KeyPath<Root, Value>) {
        self.root = root
        self.keyPath = keyPath
    }

    public var value: Value {
        root.value[keyPath: keyPath]
    }
}

@frozen
public struct Map<Source, Value>: Rule {
    public var source: Attribute<Source>
    public var body: (Source) -> Value

    public init(_ source: Attribute<Source>, _ body: @escaping (Source) -> Value) {
        self.source = source
        self.body = body
    }

    public init(_ source: Attribute<Source>, body: @escaping (Source) -> Value) {
        self.init(source, body)
    }

    public var value: Value {
        body(source.value)
    }
}

@frozen
@propertyWrapper
@dynamicMemberLookup
public struct IndirectAttribute<Value>: Hashable, Equatable {
    public var identifier: AnyAttribute

    public var source: Attribute<Value> {
        get { Attribute(identifier: identifier.source) }
        nonmutating set { identifier.source = newValue.identifier }
    }

    public var dependency: AnyAttribute? {
        get { identifier.indirectDependency }
        nonmutating set { identifier.indirectDependency = newValue }
    }

    public var wrappedValue: Value {
        get { Attribute<Value>(identifier: identifier).value }
        nonmutating set { Attribute<Value>(identifier: identifier).value = newValue }
    }

    public var projectedValue: Attribute<Value> {
        Attribute(identifier: identifier)
    }

    public subscript<Member>(dynamicMember keyPath: KeyPath<Value, Member>) -> Attribute<Member> {
        Attribute<Value>(identifier: identifier)[keyPath: keyPath]
    }

    public init(source: Attribute<Value>) {
        identifier = source.identifier.createIndirect(size: UInt64(MemoryLayout<Value>.size))
    }

    public func changedValue(options: OAGValueOptions = []) -> (value: Value, changed: Bool) {
        Attribute<Value>(identifier: identifier).changedValue(options: options)
    }

    public func valueAndFlags(options: OAGValueOptions = []) -> (value: Value, flags: OAGChangedValueFlags) {
        Attribute<Value>(identifier: identifier).valueAndFlags(options: options)
    }
}

// MARK: - Runtime helpers

private func dgComparisonOptions(_ options: ComparisonOptions) -> DGComparisonMode {
    let mode = options.rawValue & ComparisonOptions.comparisonModeMask.rawValue
    var result: DGComparisonMode
    switch mode {
    case ComparisonOptions.comparisonModeIndirect.rawValue:
        result = .indirect
    case ComparisonOptions.comparisonModeEquatableUnlessPOD.rawValue:
        result = .equatableUnlessPOD
    case ComparisonOptions.comparisonModeEquatableAlways.rawValue:
        result = .equatableAlways
    default:
        result = .bitwise
    }
    result.insert(.asynchronous)
    return result
}

public struct ComparisonOptions: OptionSet {
    public let rawValue: UInt32

    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }

    public init(mode: ComparisonMode) {
        switch mode {
        case .indirect:
            self = .comparisonModeIndirect
        case .equatableUnlessPOD:
            self = .comparisonModeEquatableUnlessPOD
        case .equatableAlways:
            self = .comparisonModeEquatableAlways
        default:
            self = .comparisonModeBitwise
        }
    }

    public static let comparisonModeBitwise: ComparisonOptions = []
    public static let comparisonModeIndirect = ComparisonOptions(rawValue: 1)
    public static let comparisonModeEquatableUnlessPOD = ComparisonOptions(rawValue: 2)
    public static let comparisonModeEquatableAlways = ComparisonOptions(rawValue: 3)
    public static let comparisonModeMask = ComparisonOptions(rawValue: 0xff)
    public static let copyOnWrite = ComparisonOptions(rawValue: 1 << 8)
    public static let fetchLayoutsSynchronously = ComparisonOptions(rawValue: 1 << 9)
    public static let traceCompareFailed = ComparisonOptions(rawValue: 1 << 31)
}

public func compareValues<Value>(_ lhs: Value, _ rhs: Value, mode: ComparisonMode = .equatableAlways) -> Bool {
    compareValues(lhs, rhs, options: [.init(mode: mode), .copyOnWrite])
}

public func compareValues<Value>(_ lhs: Value, _ rhs: Value, options: ComparisonOptions) -> Bool {
    DGCompareValues(lhs: lhs, rhs: rhs, options: dgComparisonOptions(options))
}

public func makeUniqueID() -> UniqueID {
    UInt(DGMakeUniqueID().rawValue)
}

public func withUnsafeTuple(of type: TupleType, count: Int, _ body: (UnsafeMutableTuple) -> Void) {
    DanceUIGraph.withUnsafeTuple(of: type.type, count: count) { tuple in
        body(tuple)
    }
}

extension TupleType {
    public func elementType(at index: Int) -> Metadata {
        Metadata(getElementType(at: index))
    }

    public func type(at index: Int) -> Any.Type {
        getElementType(at: index)
    }

    public func elementOffset(at index: Int) -> Int {
        offset(at: index)
    }

    public func elementOffset(at index: Int, type: Metadata) -> Int {
        func project<T>(_: T.Type) -> Int {
            offset(at: index, as: T.self)
        }
        return _openExistential(type.type, do: project)
    }

    public func elementSize(at index: Int) -> Int {
        MemoryLayout.size(ofValue: getElementType(at: index))
    }
}

extension Metadata {
    public func enumTag(_ value: UnsafeRawPointer) -> UInt32 {
        getEnumTag(value: value)
    }

    public func projectEnumData(_ value: UnsafeMutableRawPointer) {
        _ = value
    }

    public func injectEnumTag(tag: UInt32, _ value: UnsafeMutableRawPointer) {
        _ = tag
        _ = value
    }

    public var descriptor: UnsafeRawPointer? {
        nominalDescriptor
    }
}

extension UnsafePointer where Pointee == DanceUIGraphTypeSignature {
    public var bytes: (
        UInt8, UInt8, UInt8, UInt8, UInt8,
        UInt8, UInt8, UInt8, UInt8, UInt8,
        UInt8, UInt8, UInt8, UInt8, UInt8,
        UInt8, UInt8, UInt8, UInt8, UInt8
    ) {
        var signature = pointee
        let bytes = withUnsafeBytes(of: &signature) { buffer in
            Array(buffer.prefix(20))
        }
        return (
            bytes[0], bytes[1], bytes[2], bytes[3], bytes[4],
            bytes[5], bytes[6], bytes[7], bytes[8], bytes[9],
            bytes[10], bytes[11], bytes[12], bytes[13], bytes[14],
            bytes[15], bytes[16], bytes[17], bytes[18], bytes[19]
        )
    }
}

// MARK: - Option compatibility

extension AnyAttribute.Flags {
    public static var all: Self {
        Self(rawValue: ~0)
    }
}

extension ComparisonMode {
    public static var bitwise: Self { [] }
    public static var indirect: Self { .pod }
    public static var equatableUnlessPOD: Self { .inline }
    public static var equatableAlways: Self { .equatable }
}

extension OAGChangedValueFlags {
    public static var changed: Self { .updated }
    public static var requiresMainThread: Self { .requiresMainHandler }
}

extension OAGInputOptions {
    public static var inputOptionsUnprefetched: Self { Self(rawValue: 1 << 0) }
    public static var inputOptionsSyncMainRef: Self { Self(rawValue: 1 << 1) }
    public static var inputOptionsMask: Self { Self(rawValue: 0x03) }
}

extension OAGValueOptions {
    public static var incrementGraphVersion: Self { Self(rawValue: 1 << 2) }
}

extension OAGCachedValueOptions {
    public static var _1: Self { .withoutPrefetching }
    public static var _2: Self { Self(rawValue: 1 << 1) }
    public static var _4: Self { Self(rawValue: 1 << 2) }
    public static var _8: Self { Self(rawValue: 1 << 3) }
    public static var _16: Self { Self(rawValue: 1 << 4) }
}

extension SearchOptions {
    public static var searchInputs: Self { .backwards }
    public static var searchOutputs: Self { .forwards }
    public static var traverseGraphContexts: Self { Self(rawValue: 1 << 2) }
}

extension ValueState {
    public static var dirty: Self { .isDirty }
    public static var pending: Self { .isPending }
    public static var updating: Self { .isUpdating }
    public static var valueExists: Self { .hasValue }
    public static var mainThread: Self { .requiresMainThreadFromOutput }
    public static var mainRef: Self { .attributeIsMainReference }
    public static var requiresMainThread: Self { .requiresMainThreadFromInput }
    public static var selfModified: Self { .wasModified }
}

extension _AttributeType {
    public typealias Flags = DGAttributeTypeFlags
}

extension _AttributeBody {
    public typealias Flags = _AttributeType.Flags
}

extension _AttributeType.Flags {
    public static var comparisonModeBitwise: Self { Self(rawValue: 0) }
    public static var comparisonModeIndirect: Self { Self(rawValue: 1) }
    public static var comparisonModeEquatableUnlessPOD: Self { Self(rawValue: 2) }
    public static var comparisonModeEquatableAlways: Self { Self(rawValue: 3) }
    public static var comparisonModeMask: Self { Self(rawValue: 0x03) }
    public static var mainThread: Self { .threadMain }
    public static var asyncThread: Self { .threadAsync }
    public static var external: Self { .valueIndirect }
}

extension Metadata.ApplyOptions {
    public static var enumerateClassFields: Self { .heap }
    public static var continueAfterUnknownField: Self { .continueWhenUnknown }
    public static var enumerateEnumCases: Self { .allowVisitEnum }
}

extension DescriptionOption {
    public static var maxFrames: Self {
        .stackMaxFrames
    }
}

public let attributeGraphVendor = AttributeGraphVendor.danceUIGraph

#endif
