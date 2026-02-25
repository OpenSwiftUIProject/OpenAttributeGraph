//
//  GraphCompatibilityTests.swift
//  OpenAttributeGraphCompatibilityTests

import Foundation
import Testing

@MainActor
struct GraphCompatibilityTests {
    @Test
    func graphCreate() throws {
        _ = Graph()
    }

    @Test
    func graphCreateShared() throws {
        let graph = Graph()
        _ = Graph(shared: graph)
        _ = Graph(shared: nil)
    }

    #if canImport(Darwin)
    @Test(.disabled(if: !compatibilityTestEnabled, "Not implemented on OAG"))
    func graphArchiveJSON() throws {
        struct Graphs: Codable {
            var version: Int
            var graphs: [Graph]
            struct Graph: Codable {}
        }
        let name = "empty_graph.json"
        name.withCString { Graph.archiveJSON(name: $0) }
        let url = if #available(macOS 13.0, iOS 16.0, tvOS 16.0, watchOS 9.0, *) {
            URL(filePath: NSTemporaryDirectory().appending(name))
        } else {
            URL(fileURLWithPath: NSTemporaryDirectory().appending(name))
        }
        let data = try Data(contentsOf: url)
        let graphs = try JSONDecoder().decode(Graphs.self, from: data)
        #expect(graphs.version == 2)
    }

    @Test(.disabled(if: !compatibilityTestEnabled, "Not implemented on OAG"))
    func graphDescriptionDict() throws {
        let description = try #require(Graph.description(
            nil,
            options: [
                DescriptionOption.format: Graph.descriptionFormatDictionary
            ] as NSDictionary
        ))
        let dic = description as! [String: AnyHashable]
        #expect(dic["version"] as? UInt32 == 2)
        #expect((dic["graphs"] as? NSArray)?.count == 0)
    }

    @Test(.disabled(if: !compatibilityTestEnabled, "Not implemented on OAG"))
    func graphDescriptionDot() throws {
        let options = NSMutableDictionary()
        options[DescriptionOption.format] = Graph.descriptionFormatDot
        #expect(Graph.description(nil, options: options) == nil)
        let graph = Graph()
        let description = try #require(Graph.description(graph, options: options))
        let dotGraph = description as! String
        let expectedEmptyDotGraph = #"""
        digraph {
        }

        """#
        #expect(dotGraph == expectedEmptyDotGraph)
    }

    @Test
    func graphCallback() {
        let graph = Graph()
        graph.onUpdate {
            print("Update")
        }
        graph.onInvalidation { attr in
            print("Invalidate \(attr)")
        }
    }

    @Test(.disabled(if: !compatibilityTestEnabled, "Not implemented on OAG"))
    func counter() {
        let graph = Graph()
        #expect(graph.mainUpdates == 0)
    }
    #endif

    @Test(.disabled(if: !compatibilityTestEnabled, "Not implemented on OAG"))
    func beginDeferringSubgraphInvalidation() {
        let graph = Graph()

        let wasDeferring1 = graph.beginDeferringSubgraphInvalidation()
        #expect(wasDeferring1 == false)

        let wasDeferring2 = graph.beginDeferringSubgraphInvalidation()
        #expect(wasDeferring2 == true)

        graph.endDeferringSubgraphInvalidation(wasDeferring: wasDeferring2)
        graph.endDeferringSubgraphInvalidation(wasDeferring: wasDeferring1)
    }
}
