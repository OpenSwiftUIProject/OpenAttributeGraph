//
//  SubgraphCompatibilityTests.swift
//  OpenAttributeGraphCompatibilityTests

import Testing

@MainActor
@Suite(.enabled(if: compatibilityTestEnabled), .graphScope)
struct SubgraphCompatibilityTests {
    @Test
    func shouldRecordTree() {
        let key = compatibilityTestEnabled ? "AG_TREE" : "OAG_TREE"
        setenv(key, "0", 1)
        #expect(Subgraph.shouldRecordTree == false)
        
        Subgraph.setShouldRecordTree()
        #expect(Subgraph.shouldRecordTree == true)
    }
    
    @Test
    func treeElementAPICheck() {
        let graph = Graph()
        let subgraph = Subgraph(graph: graph)
        subgraph.apply {
            let value = Attribute(value: ())
            Subgraph.beginTreeElement(value: value, flags: 0)
            Subgraph.addTreeValue(value, forKey: "", flags: 0)
            Subgraph.endTreeElement(value: value)
        }
    }

    @Suite
    struct ObserverTests {
        @Test
        func observerNotifiedOnSubgraphDestroyed() {
            var notifiedCount = 0
            do {
                let graph = Graph()
                do {
                    let subgraph = Subgraph(graph: graph)
                    let _ = subgraph.addObserver {
                        notifiedCount += 1
                    }
                }
                #expect(notifiedCount == 1)
            }
            // Observers aren't notified more than once
            #expect(notifiedCount == 1)
        }

        @Test
        func observerNotifiedOnGraphDestroyed() {
            var notifiedCount = 0
            do {
                let graph = Graph()
                let subgraph = Subgraph(graph: graph)
                let _ = subgraph.addObserver {
                    notifiedCount += 1
                }
                #expect(notifiedCount == 0)
            }
            #expect(notifiedCount == 1)
        }

        @Test
        func removedObserverNotNotified() {
            var notifiedCount = 0
            do {
                let graph = Graph()
                let subgraph = Subgraph(graph: graph)
                let observerID = subgraph.addObserver {
                    notifiedCount += 1
                }
                subgraph.removeObserver(observerID)
            }
            #expect(notifiedCount == 0)
        }
    }
}
