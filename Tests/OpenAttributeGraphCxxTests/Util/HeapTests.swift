//
//  HeapTests.swift
//  OpenAttributeGraphCxxTests

import OpenAttributeGraphCxx_Private.Util
import Testing

struct HeapTests {
    @Test
    func heapBasicOperations() {
        let heap = util.Heap.create(nil, 0, 1024)
        defer { util.Heap.destroy(heap) }
        
        // Test heap creation and basic properties
        #expect(heap.increment() == 1024)
        #expect(heap.num_nodes() >= 0)
        #expect(heap.capacity() >= 0)
    }
    
    @Test
    func heapMinimumIncrement() {
        // Test with minimum increment constant (0x400 = 1024 bytes)
        let minimumIncrement = 0x400
        
        // Create heap with minimum increment
        let heap = util.Heap.create(nil, 0, minimumIncrement)
        defer { util.Heap.destroy(heap) }
        
        #expect(heap.increment() == minimumIncrement)
    }
    
    @Test
    func heapWithInitialBuffer() {
        var buffer = Array<UInt8>(repeating: 0, count: 1024)
        
        let heap = buffer.withUnsafeMutableBytes { bufferPtr in
            let charPtr = bufferPtr.bindMemory(to: CChar.self)
            return util.Heap.create(charPtr.baseAddress, 1024, 2048)
        }
        defer { util.Heap.destroy(heap) }
        
        #expect(heap.capacity() == 1024)
        #expect(heap.increment() == 2048)
    }
    
    @Test
    func heapReset() {
        let heap = util.Heap.create(nil, 0, 1024)
        defer { util.Heap.destroy(heap) }
        
        // Reset heap
        heap.reset(nil, 0)
        
        // Verify heap is still operational after reset
        #expect(heap.increment() == 1024)
        #expect(heap.num_nodes() >= 0)
    }
    
    @Test
    func heapPrint() {
        let heap = util.Heap.create(nil, 0, 1024)
        defer { util.Heap.destroy(heap) }
        
        // Test print method doesn't crash and can be called
        // This method prints debug information to stdout
        heap.print()
        
        // Verify heap is still functional after print
        #expect(heap.increment() == 1024)
        #expect(heap.num_nodes() >= 0)
        #expect(heap.capacity() >= 0)
    }
}
