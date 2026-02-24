//
//  HashTableTests.swift
//  OpenAttributeGraphCxxTests

import Utilities
import Testing

@Suite("HashTable tests")
struct HashTableTests {

    @Test("Initialize empty table")
    @available(iOS 16.4, *)
    func initEmpty() {
        let table = util.UntypedTable.create()
        defer {
            util.UntypedTable.destroy(table)
        }

        #expect(table.empty())
        #expect(table.count() == 0)
    }

    @Test("Insert entry")
    @available(iOS 16.4, *)
    func insertEntry() {
        class Value {
            let prop: String
            init(prop: String) {
                self.prop = prop
            }
        }

        let table = util.UntypedTable.create()
        defer {
            util.UntypedTable.destroy(table)
        }

        let key = "key1"
        let value = Value(prop: "valueProp")
        withUnsafePointer(to: key) { keyPointer in
            withUnsafePointer(to: value) { valuePointer in
                let inserted = table.insert(keyPointer, valuePointer)

                #expect(inserted == true)
                #expect(!table.empty())
                #expect(table.count() == 1)

                // Verify the value can be found
                let foundValue = table.__lookupUnsafe(keyPointer, nil)
                #expect(foundValue?.assumingMemoryBound(to: Value.self).pointee.prop == "valueProp")
            }
        }
    }
    
    @Test("Insert multiple entries")
    @available(iOS 16.4, *)
    func insertMultipleEntries() {
        class Value {
            let prop: String
            init(prop: String) {
                self.prop = prop
            }
        }

        let table = util.UntypedTable.create()
        defer {
            util.UntypedTable.destroy(table)
        }

        // Use manually allocated pointers to ensure unique addresses
        let key1Ptr = UnsafeMutablePointer<Int>.allocate(capacity: 1)
        let key2Ptr = UnsafeMutablePointer<Int>.allocate(capacity: 1)  
        let key3Ptr = UnsafeMutablePointer<Int>.allocate(capacity: 1)
        
        defer {
            key1Ptr.deallocate()
            key2Ptr.deallocate()
            key3Ptr.deallocate()
        }
        
        key1Ptr.pointee = 1
        key2Ptr.pointee = 2
        key3Ptr.pointee = 3

        let value1 = Value(prop: "value1")
        let value2 = Value(prop: "value2")
        let value3 = Value(prop: "value3")

        // Insert entries using unique heap-allocated pointers as keys
        withUnsafePointer(to: value1) { valuePointer in
            let inserted = table.insert(key1Ptr, valuePointer)
            #expect(inserted == true)
        }

        withUnsafePointer(to: value2) { valuePointer in
            let inserted = table.insert(key2Ptr, valuePointer)
            #expect(inserted == true)
        }

        withUnsafePointer(to: value3) { valuePointer in
            let inserted = table.insert(key3Ptr, valuePointer)
            #expect(inserted == true)
        }

        #expect(!table.empty())
        #expect(table.count() == 3)
    }
    
    @Test("Remove entry")
    @available(iOS 16.4, *)
    func removeEntry() {
        class Value {
            let prop: String
            init(prop: String) {
                self.prop = prop
            }
        }

        let table = util.UntypedTable.create()
        defer {
            util.UntypedTable.destroy(table)
        }

        let key = "key1"
        let value = Value(prop: "valueProp")
        withUnsafePointer(to: key) { keyPointer in
            withUnsafePointer(to: value) { valuePointer in
                let inserted = table.insert(keyPointer, valuePointer)

                try! #require(inserted == true)
                try! #require(table.count() == 1)

                let removed = table.remove(keyPointer)

                #expect(removed == true)
                #expect(table.count() == 0)
                #expect(table.empty())

                // Verify the value can no longer be found
                let foundValue = table.__lookupUnsafe(keyPointer, nil)
                #expect(foundValue == nil)
            }
        }
    }

    @Test("Remove from empty table")
    @available(iOS 16.4, *)
    func removeFromEmptyTable() {
        let table = util.UntypedTable.create()
        defer {
            util.UntypedTable.destroy(table)
        }

        let key = "nonexistent"
        withUnsafePointer(to: key) { keyPointer in
            let removed = table.remove(keyPointer)
            #expect(removed == false)
            #expect(table.count() == 0)
        }
    }
}
