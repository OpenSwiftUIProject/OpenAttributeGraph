//
//  HeapTests.swift
//  OpenAttributeGraphCxxTests

import OpenAttributeGraphCxx_Private.Util
import Testing

@Suite("Heap tests")
struct HeapTests {

    let nodeSize = 16

    @Test("Initializing with default arguments")
    @available(iOS 16.4, *)
    func initDefault() {
        let heap = util.Heap.create(nil, 0, 0)
        defer {
            util.Heap.destroy(heap)
        }

        #expect(heap.capacity() == 0)
        #expect(heap.increment() == 0x2000)
        #expect(heap.num_nodes() == 0)
    }
    
    @Test("Initializing with custom increment")
    @available(iOS 16.4, *)
    func initWithCustomIncrement() {
        let customIncrement = 4096
        let heap = util.Heap.create(nil, 0, customIncrement)
        defer {
            util.Heap.destroy(heap)
        }

        #expect(heap.capacity() == 0)
        #expect(heap.increment() == customIncrement)
        #expect(heap.num_nodes() == 0)
    }

    @Test("Creating heap with initial buffer")
    @available(iOS 16.4, *)
    func createWithInitialBuffer() {
        var buffer = Array<UInt8>(repeating: 0, count: 1024)
        
        let heap = buffer.withUnsafeMutableBytes { bufferPtr in
            let charPtr = bufferPtr.bindMemory(to: CChar.self)
            return util.Heap.create(charPtr.baseAddress, 1024, 2048)
        }
        defer {
            util.Heap.destroy(heap)
        }
        
        #expect(heap.capacity() == 1024)
        #expect(heap.increment() == 2048)
        #expect(heap.num_nodes() == 0)
    }

    @Test("Reset heap functionality")
    @available(iOS 16.4, *)
    func resetHeap() {
        let heap = util.Heap.create(nil, 0, 1024)
        defer {
            util.Heap.destroy(heap)
        }
        
        // Reset heap to different configuration
        heap.reset(nil, 0)
        
        // Verify heap properties after reset
        #expect(heap.increment() == 1024)
        #expect(heap.capacity() == 0)
        #expect(heap.num_nodes() == 0)
    }

    @Test("Print heap debug information")
    @available(iOS 16.4, *)
    func printHeapInfo() {
        let heap = util.Heap.create(nil, 0, 1024)
        defer {
            util.Heap.destroy(heap)
        }
        
        // Test that print method can be called without crashing
        heap.print()
        
        // Verify heap is still functional after print
        #expect(heap.increment() == 1024)
        #expect(heap.num_nodes() == 0)
        #expect(heap.capacity() == 0)
    }
}
