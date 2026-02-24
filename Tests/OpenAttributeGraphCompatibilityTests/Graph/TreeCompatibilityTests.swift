//
//  TreeCompatibilityTests.swift
//  OpenAttributeGraphCompatibilityTests

import Testing

@MainActor
@Suite(.graphScope)
struct TreeCompatibilityTests {
    
    @Test
    func treeElement() {
        let graph = Graph()
        let subgraph = Subgraph(graph: graph)
        
        let treeElement = subgraph.treeRoot
        #expect(treeElement == nil)
        
        let _ = treeElement?.type
        let _ = treeElement?.value
        let _ = treeElement?.flags
        let _ = treeElement?.parent
    }
    
    @Test
    func values() {
        let graph = Graph()
        let subgraph = Subgraph(graph: graph)
        
        let treeElement = subgraph.treeRoot
        var values = treeElement?.values
        
        let treeValue = values?.next()
        let _ = treeValue?.type
        let _ = treeValue?.value
        let _ = treeValue?.key
        let _ = treeValue?.flags
    }
    
    @Test
    func nodes() {
        let graph = Graph()
        let subgraph = Subgraph(graph: graph)
        
        let treeElement = subgraph.treeRoot
        var nodes = treeElement?.nodes
        
        let _ = nodes?.next()
    }
    
    @Test
    func children() {
        let graph = Graph()
        let subgraph = Subgraph(graph: graph)
        
        let treeElement = subgraph.treeRoot
        var children = treeElement?.children
        
        let _ = children?.next()
    }
}
