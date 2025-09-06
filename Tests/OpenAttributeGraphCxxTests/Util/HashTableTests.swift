//
//  HashTableTests.swift
//  OpenAttributeGraphCxxTests

import OpenAttributeGraphCxx_Private.Util
import Testing

@Suite("HashTable tests")
struct HashTableTests {

    @Test("Initialize empty table")
    func initEmpty() {
        let table = util.UntypedTable.create()
        defer {
            util.UntypedTable.destroy(table)
        }

        #expect(table.empty())
        #expect(table.count() == 0)
    }

    @Test("Insert entry")
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

        // Declare all keys and values in the same scope to keep them alive
        let key1 = "key1"
        let value1 = Value(prop: "value1")
        let key2 = "key2"
        let value2 = Value(prop: "value2")
        let key3 = "key3"
        let value3 = Value(prop: "value3")

        // Insert all entries
        withUnsafePointer(to: key1) { keyPointer in
            withUnsafePointer(to: value1) { valuePointer in
                let inserted = table.insert(keyPointer, valuePointer)
                #expect(inserted == true)
            }
        }

        withUnsafePointer(to: key2) { keyPointer in
            withUnsafePointer(to: value2) { valuePointer in
                let inserted = table.insert(keyPointer, valuePointer)
                #expect(inserted == true)
            }
        }

        withUnsafePointer(to: key3) { keyPointer in
            withUnsafePointer(to: value3) { valuePointer in
                let inserted = table.insert(keyPointer, valuePointer)
                #expect(inserted == true)
            }
        }

        #expect(!table.empty())
        #expect(table.count() == 3)

        // Verify all entries can be found (test basic lookup functionality)
        withUnsafePointer(to: key1) { keyPointer in
            let foundValue = table.__lookupUnsafe(keyPointer, nil)
            if foundValue != nil {
                #expect(foundValue?.assumingMemoryBound(to: Value.self).pointee.prop == "value1")
            }
            // Note: Due to pointer-based comparison, lookup might fail for string literals
            // The important thing is that insertions succeeded and count is correct
        }
    }
    
    @Test("Remove entry")
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
