//
//  ForwardListTests.swift
//  OpenAttributeGraphCxxTests

import OpenAttributeGraphCxx_Private.Util
import Testing

struct ForwardListTests {
    @Test
    func forwardListBasicOperations() {
        let list = util.UInt64ForwardList.create()
        defer { util.UInt64ForwardList.destroy(list) }
        
        // Test empty list
        #expect(list.empty())
        
        // Test push_front and empty state
        list.push_front(42)
        #expect(!list.empty())
        
        // Test front access
        #expect(list.front() == 42)
        
        // Test multiple push_front operations
        list.push_front(100)
        #expect(list.front() == 100)
        
        list.push_front(200)
        #expect(list.front() == 200)
        
        // Test pop_front
        list.pop_front()
        #expect(list.front() == 100)
        
        list.pop_front()
        #expect(list.front() == 42)
        
        list.pop_front()
        #expect(list.empty())
    }
    
    @Test
    func forwardListSequentialOperations() {
        let list = util.UInt64ForwardList.create()
        defer { util.UInt64ForwardList.destroy(list) }
        
        // Add multiple elements
        for i in 0..<5 {
            list.push_front(UInt64(i))
        }
        
        // Remove all elements and verify order (LIFO - last in, first out)
        for i in (0..<5).reversed() {
            #expect(!list.empty())
            #expect(list.front() == UInt64(i))
            list.pop_front()
        }
        
        #expect(list.empty())
    }
}
