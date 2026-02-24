//
//  ForwardListTests.swift
//  UtilitiesTests

import Utilities
import Testing

@Suite("List tests")
struct ForwardListTests {

    @Test("Initialize empty list")
    @available(iOS 16.4, *)
    func initEmpty() {
        let list = util.UInt64ForwardList.create()
        defer {
            util.UInt64ForwardList.destroy(list)
        }

        #expect(list.empty())
    }

    @Test("Push element")
    @available(iOS 16.4, *)
    func pushElement() {
        let list = util.UInt64ForwardList.create()
        defer {
            util.UInt64ForwardList.destroy(list)
        }

        list.push_front(1)

        #expect(list.empty() == false)

        let front = list.front()
        #expect(front == 1)
    }

    @Test("Push multiple elements")
    @available(iOS 16.4, *)
    func pushMultipleElements() {
        let list = util.UInt64ForwardList.create()
        defer {
            util.UInt64ForwardList.destroy(list)
        }

        list.push_front(1)
        list.push_front(2)
        list.push_front(3)

        let front = list.front()
        #expect(front == 3)
    }

    @Test("Remove element")
    @available(iOS 16.4, *)
    func removeElement() {
        let list = util.UInt64ForwardList.create()
        defer {
            util.UInt64ForwardList.destroy(list)
        }

        list.push_front(1)
        list.push_front(2)
        list.push_front(3)
        list.pop_front()

        let front = list.front()
        #expect(front == 2)
    }
    
    @Test("Sequential operations")
    @available(iOS 16.4, *)
    func sequentialOperations() {
        let list = util.UInt64ForwardList.create()
        defer {
            util.UInt64ForwardList.destroy(list)
        }
        
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
