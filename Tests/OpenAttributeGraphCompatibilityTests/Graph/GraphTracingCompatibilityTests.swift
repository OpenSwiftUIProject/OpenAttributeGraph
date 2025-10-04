//
//  GraphTracingCompatibilityTests.swift
//  OpenAttributeGraphCompatibilityTests

import Testing

struct GraphTracingCompatibilityTests {
    @Test
    func tracing() {
        let graph = Graph()
        Graph.startTracing(graph, options: [])
        Graph.syncTracing(graph)
        Graph.stopTracing(graph)
    }
    
    @Test
    func tracePath() {
        let graph = Graph()
        let tracePath = Graph.tracePath(graph)
        #expect(tracePath == nil)
    }
    
    @Test(.disabled(if: !compatibilityTestEnabled, "Not implemented on OAG"))
    func setTrace() {
        let graph = Graph()
        #expect(graph.isTracingActive == false)
        
        var trace = AGTrace()
        withUnsafeMutablePointer(to: &trace) { tracePointer in
            graph.setTrace(tracePointer, context: nil)
        }
        #expect(graph.isTracingActive == true)
        
        graph.resetTrace()
        #expect(graph.isTracingActive == false)
    }
    
    @Test(.disabled(if: !compatibilityTestEnabled, "Not implemented on OAG"))
    func traceEventRegistration() {
        let eventID = "TEST_EVENT".withCString { namePtr in
            "TEST_SUBSYSTEM".withCString { subsystemPtr in
                Graph.registerNamedTraceEvent(name: namePtr, subsystem: subsystemPtr)
            }
        }
        
        let name = Graph.traceEventName(for: eventID)
        #expect(name.map { String(cString: $0) } == "TEST_EVENT")
        
        let subsystem = Graph.traceEventSubsystem(for: eventID)
        #expect(subsystem.map { String(cString: $0) } == "TEST_SUBSYSTEM")
    }

    @Test
    func tracingAll() {
        Graph.startTracing(nil, options: [])
        Graph.stopTracing(nil)
    }

    @Test
    func options() {
        let option = Graph.TraceOptions(rawValue: 1)
        #expect(option == .enabled)
    }
}
