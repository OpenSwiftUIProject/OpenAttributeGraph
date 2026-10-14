//
//  Graph.swift
//  OpenAttributeGraph
//
//  Audited for 3.2.1
//  Status: WIP

public import OpenAttributeGraphCxx

extension Graph {
    @_silgen_name("OAGGraphInternAttributeType")
    public static func typeIndex(
        ctx: UnownedGraphContext,
        body: Metadata,
        makeAttributeType: () -> UnsafePointer<_AttributeType>
    ) -> Int
}

@_silgen_name("OAGGraphSetInvalidationCallback")
private func OAGGraphSetInvalidationCallback(
    graph: Graph,
    _ callback: @escaping (AnyAttribute) -> Void
)

@_silgen_name("OAGGraphSetUpdateCallback")
private func OAGGraphSetUpdateCallback(
    graph: Graph,
    _ callback: @escaping () -> Void
)

extension Graph {
    public static func withoutUpdate<V>(_ body: () -> V) -> V {
        let update = clearUpdate()
        defer { setUpdate(update) }
        return body()
    }

    public func withoutSubgraphInvalidation<V>(_ body: () -> V) -> V {
        preconditionFailure("TODO")
    }

    public func withDeadline<V>(
        _: UInt64,
        _: () -> V
    ) -> V {
        preconditionFailure("TODO")
    }

    public func onInvalidation(_ callback: @escaping (AnyAttribute) -> Void) {
        OAGGraphSetInvalidationCallback(graph: self, callback)
    }

    public func onUpdate(_ callback: @escaping () -> Void) {
        OAGGraphSetUpdateCallback(graph: self, callback)
    }

    public func withMainThreadHandler(_: (() -> Void) -> Void, do: () -> Void) {
        // TODO: OAGGraphWithMainThreadHandler
        preconditionFailure("TODO")
    }
}

extension Graph {
    @_transparent
    public func startProfiling() {
        __OAGGraphStartProfiling(self)
    }

    @_transparent
    public func stopProfiling() {
        __OAGGraphStopProfiling(self)
    }

    @_transparent
    public func resetProfile() {
        __OAGGraphResetProfile(self)
    }

    public static func startProfiling() {
        __OAGGraphStartProfiling(nil)
    }

    public static func stopProfiling() {
        __OAGGraphStopProfiling(nil)
    }

    public static func resetProfile() {
        __OAGGraphResetProfile(nil)
    }
}

extension Graph {
    @_transparent
    public var mainUpdates: Int { numericCast(counter(for: .mainThreadUpdates)) }
}

extension Graph {
    // NOTE: Currently Swift does not support generic computed variable
    @_silgen_name("OAGGraphGetOutputValue")
    @inline(__always)
    @inlinable
    public static func outputValue<Value>() -> UnsafePointer<Value>?

    @_silgen_name("OAGGraphSetOutputValue")
    @inline(__always)
    @inlinable
    public static func setOutputValue<Value>(_ value: UnsafePointer<Value>)
}

extension Graph {
    @_transparent
    public static func anyInputsChanged(excluding excludedInputs: [AnyAttribute]) -> Bool {
        return __OAGGraphAnyInputsChanged(excludedInputs, excludedInputs.count)
    }
}

#if canImport(Darwin)
import Foundation
#endif

extension Graph {
    public func archiveJSON(name: String?) {
        #if canImport(Darwin)
        let options: NSDictionary = [
            DescriptionOption.format: "graph/dict",
            DescriptionOption.includeValues: true,
        ]
        guard let description = Graph.description(self, options: options) as? [String: Any] else {
            return
        }
        var name = name ?? "graph"
        name.append(".ag-json")
        let path = (NSTemporaryDirectory() as NSString).appendingPathComponent(name)
        guard let data = try? JSONSerialization.data(withJSONObject: description, options: []) else {
            return
        }
        let url = URL(fileURLWithPath: path)
        do {
            try data.write(to: url, options: [])
            print("Wrote graph data to \"\(path)\".")
        } catch {}
        #endif
    }
}
