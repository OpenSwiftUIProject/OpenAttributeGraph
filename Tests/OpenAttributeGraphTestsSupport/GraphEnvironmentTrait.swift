//
//  GraphEnvironmentTrait.swift
//  OpenAttributeGraphTestsSupport

public import Testing

public struct GraphEnvironmentTrait: TestTrait, TestScoping, SuiteTrait {
    #if OPENATTRIBUTEGRAPH_DANCEUIGRAPH
    private static let sharedGraph = DGGraphCreate()
    #else
    private static let sharedGraph = Graph()
    #endif
    private static let semaphore = AsyncSemaphore(value: 1)

    @MainActor
    public func provideScope(
        for test: Test,
        testCase: Test.Case?,
        performing function: @Sendable () async throws -> Void
    ) async throws {
        await Self.semaphore.wait()
        defer { Self.semaphore.signal() }
        #if OPENATTRIBUTEGRAPH_DANCEUIGRAPH
        let graph = DGGraphCreateShared(Self.sharedGraph)
        let subgraph = DGSubgraphCreate(graph)
        let oldSubgraph = Subgraph.current

        Subgraph.current = subgraph
        defer {
            Subgraph.current = oldSubgraph
            subgraph.invalidate()
            graph.invalidate()
        }
        try await function()
        #else
        let graph = Graph(shared: Self.sharedGraph)
        let subgraph = Subgraph(graph: graph)
        let oldSubgraph = Subgraph.current

        Subgraph.current = subgraph
        try await function()
        Subgraph.current = oldSubgraph
        #endif
    }

    public var isRecursive: Bool {
        true
    }
}

extension Trait where Self == GraphEnvironmentTrait {
    public static var graphScope: Self {
        GraphEnvironmentTrait()
    }
}
