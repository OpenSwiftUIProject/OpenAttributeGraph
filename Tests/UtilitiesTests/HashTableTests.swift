//
//  HashTableTests.swift
//  UtilitiesTests

import Utilities
import Testing

// CustomTableTestHelper uses static counters for C function pointer callbacks
// (C callbacks can't capture per-instance state). @MainActor ensures tests
// touching those shared counters run serially on the main actor, preventing
// data races while keeping the rest of the suite concurrent-safe.
@Suite("HashTable tests")
@MainActor
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
    func removeEntry() throws {
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
        try withUnsafePointer(to: key) { keyPointer in
            try withUnsafePointer(to: value) { valuePointer in
                let inserted = table.insert(keyPointer, valuePointer)

                try #require(inserted == true)
                try #require(table.count() == 1)

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

    @Test("Remove head of bucket then insert - should not create cycle")
    @available(iOS 16.4, *)
    func removeHeadThenInsert() {
        let table = util.UntypedTable.create()
        defer {
            util.UntypedTable.destroy(table)
        }

        // We'll insert many items to increase chance of bucket collisions
        // With 16 initial buckets, inserting 32 items guarantees collisions
        var keys: [Int] = Array(0..<32)

        // Insert all keys
        for i in 0..<keys.count {
            withUnsafePointer(to: &keys[i]) { keyPointer in
                let inserted = table.insert(keyPointer, keyPointer)
                #expect(inserted == true)
            }
        }

        #expect(table.count() == 32)

        // Remove first key (likely head of some bucket)
        withUnsafePointer(to: &keys[0]) { keyPointer in
            let removed = table.remove(keyPointer)
            #expect(removed == true)
        }

        #expect(table.count() == 31)

        // Insert a new key - this will reuse the spare node from removal
        var newKey = 100
        withUnsafePointer(to: &newKey) { keyPointer in
            let inserted = table.insert(keyPointer, keyPointer)
            #expect(inserted == true)
        }

        #expect(table.count() == 32)

        // Count iterations via for_each - if there's a cycle, this will exceed count
        // or hang forever. We use a manual iteration limit to detect cycles.
        var iterationCount = 0

        table.for_each({ _, _, context in
            let countPtr = context.assumingMemoryBound(to: Int.self)
            countPtr.pointee += 1
            // If we've iterated too many times, we have a cycle
            if countPtr.pointee > 100 {
                fatalError("Cycle detected in hash table - iteration count exceeded expected")
            }
        }, &iterationCount)

        #expect(iterationCount == 32, "for_each should visit exactly count() items")
    }

    @Test("Remove and reinsert same key - lookup should work")
    @available(iOS 16.4, *)
    func removeAndReinsertSameKey() {
        let table = util.UntypedTable.create()
        defer {
            util.UntypedTable.destroy(table)
        }

        var key1 = 1
        var key2 = 2
        var value1 = 100
        var value2 = 200

        // Insert two keys
        withUnsafePointer(to: &key1) { k1 in
            withUnsafePointer(to: &value1) { v1 in
                _ = table.insert(k1, v1)
            }
        }
        withUnsafePointer(to: &key2) { k2 in
            withUnsafePointer(to: &value2) { v2 in
                _ = table.insert(k2, v2)
            }
        }

        #expect(table.count() == 2)

        // Remove first key
        withUnsafePointer(to: &key1) { k1 in
            let removed = table.remove(k1)
            #expect(removed == true)
        }

        #expect(table.count() == 1)

        // Verify key1 is not found
        withUnsafePointer(to: &key1) { k1 in
            let found = table.__lookupUnsafe(k1, nil)
            #expect(found == nil, "Removed key should not be found")
        }

        // Verify key2 is still found
        withUnsafePointer(to: &key2) { k2 in
            let found = table.__lookupUnsafe(k2, nil)
            #expect(found != nil, "Remaining key should still be found")
        }

        // Reinsert key1 with a new value
        var value1New = 999
        withUnsafePointer(to: &key1) { k1 in
            withUnsafePointer(to: &value1New) { v1 in
                let inserted = table.insert(k1, v1)
                #expect(inserted == true, "Reinserting removed key should succeed")
            }
        }

        #expect(table.count() == 2)

        // Verify key1 is found with new value
        withUnsafePointer(to: &key1) { k1 in
            let found = table.__lookupUnsafe(k1, nil)
            #expect(found != nil, "Reinserted key should be found")
            if let found = found {
                #expect(found.assumingMemoryBound(to: Int.self).pointee == 999, "Reinserted key should have new value")
            }
        }

        // Count via for_each should be 2
        var iterationCount = 0
        table.for_each({ _, _, context in
            let countPtr = context.assumingMemoryBound(to: Int.self)
            countPtr.pointee += 1
        }, &iterationCount)

        #expect(iterationCount == 2, "for_each should visit exactly 2 items after reinsertion")
    }

    // MARK: - Custom table tests (non-pointer compare path)

    @Test("Custom table: insert and lookup by string content")
    @available(iOS 16.4, *)
    func customTableInsertAndLookup() throws {
        util.CustomTableTestHelper.reset_counters()
        let table = util.CustomTableTestHelper.create()
        defer {
            util.CustomTableTestHelper.destroy(table)
        }

        #expect(table.empty())

        // Use strdup for persistent C strings the table can store safely
        let key1 = strdup("hello")!
        let inserted = table.insert(key1, nil)
        #expect(inserted == true)
        #expect(table.count() == 1)

        // Lookup with a different pointer but same string content
        let key2 = strdup("hello")!
        defer { free(key2) }

        var foundKey: UnsafePointer<CChar>? = nil
        _ = table.__lookupUnsafe(key2, &foundKey)
        let foundStr = try #require(foundKey, "Key should be found via custom compare")
        #expect(String(cString: foundStr) == "hello")
    }

    @Test("Custom table: insert duplicate replaces value")
    @available(iOS 16.4, *)
    func customTableInsertDuplicate() {
        util.CustomTableTestHelper.reset_counters()
        let table = util.CustomTableTestHelper.create()
        defer {
            util.CustomTableTestHelper.destroy(table)
        }

        var value1 = 100
        var value2 = 200

        let key1 = strdup("key1")!
        let inserted1 = withUnsafePointer(to: &value1) { v in
            table.insert(key1, v)
        }
        #expect(inserted1 == true)
        #expect(table.count() == 1)

        let keyCountBefore = util.CustomTableTestHelper.remove_key_count()
        let valCountBefore = util.CustomTableTestHelper.remove_value_count()

        // Insert same key content again - should replace, not add
        let key1dup = strdup("key1")!
        let inserted2 = withUnsafePointer(to: &value2) { v in
            table.insert(key1dup, v)
        }
        #expect(inserted2 == false, "Duplicate insert should return false")
        #expect(table.count() == 1, "Count should not change on replace")

        // Callbacks should have been called for the old key/value
        #expect(util.CustomTableTestHelper.remove_key_count() == keyCountBefore + 1)
        #expect(util.CustomTableTestHelper.remove_value_count() == valCountBefore + 1)
        free(key1) // old key was replaced, free it
    }

    @Test("Custom table: remove calls callbacks")
    @available(iOS 16.4, *)
    func customTableRemoveCallbacks() {
        util.CustomTableTestHelper.reset_counters()
        let table = util.CustomTableTestHelper.create()
        defer {
            util.CustomTableTestHelper.destroy(table)
        }

        var value1 = 42
        let key1 = strdup("removeMe")!
        withUnsafePointer(to: &value1) { v in
            _ = table.insert(key1, v)
        }
        #expect(table.count() == 1)

        let keyCountBefore = util.CustomTableTestHelper.remove_key_count()
        let valCountBefore = util.CustomTableTestHelper.remove_value_count()

        // Remove using custom compare (non-pointer path) with different pointer
        let key2 = strdup("removeMe")!
        defer { free(key2) }
        let removed = table.remove(key2)
        #expect(removed == true)
        #expect(table.count() == 0)

        #expect(util.CustomTableTestHelper.remove_key_count() == keyCountBefore + 1)
        #expect(util.CustomTableTestHelper.remove_value_count() == valCountBefore + 1)
        free(key1) // removed key, free it
    }

    @Test("Custom table: remove non-existent key returns false")
    @available(iOS 16.4, *)
    func customTableRemoveNonExistent() {
        util.CustomTableTestHelper.reset_counters()
        let table = util.CustomTableTestHelper.create()
        defer {
            util.CustomTableTestHelper.destroy(table)
        }

        var value = 1
        let key1 = strdup("existing")!
        withUnsafePointer(to: &value) { v in
            _ = table.insert(key1, v)
        }

        let key2 = strdup("nonexistent")!
        defer { free(key2) }
        let removed = table.remove(key2)
        #expect(removed == false)
        #expect(table.count() == 1)
    }

    @Test("Custom table: destructor calls callbacks for remaining entries")
    @available(iOS 16.4, *)
    func customTableDestructorCallbacks() {
        util.CustomTableTestHelper.reset_counters()

        let table = util.CustomTableTestHelper.create()
        var v1 = 10
        var v2 = 20
        let keyA = strdup("a")!
        let keyB = strdup("b")!
        withUnsafePointer(to: &v1) { v in
            _ = table.insert(keyA, v)
        }
        withUnsafePointer(to: &v2) { v in
            _ = table.insert(keyB, v)
        }
        #expect(table.count() == 2)

        // Destroy the table - should trigger callbacks for remaining 2 entries
        util.CustomTableTestHelper.destroy(table)

        #expect(util.CustomTableTestHelper.remove_key_count() == 2)
        #expect(util.CustomTableTestHelper.remove_value_count() == 2)
    }

    @Test("Custom table: lookup with found_key_out")
    @available(iOS 16.4, *)
    func customTableLookupFoundKeyOut() {
        util.CustomTableTestHelper.reset_counters()
        let table = util.CustomTableTestHelper.create()
        defer {
            util.CustomTableTestHelper.destroy(table)
        }

        var value = 99
        let key1 = strdup("theKey")!
        withUnsafePointer(to: &value) { v in
            _ = table.insert(key1, v)
        }

        // Lookup with found_key_out using different pointer with same content
        let key2 = strdup("theKey")!
        defer { free(key2) }
        var foundKey: UnsafePointer<CChar>? = nil
        let result = table.__lookupUnsafe(key2, &foundKey)
        #expect(foundKey != nil, "found_key_out should be set on match")
        #expect(result != nil, "Value should be returned")

        // Lookup non-existent with found_key_out
        let key3 = strdup("missing")!
        defer { free(key3) }
        var foundKey2: UnsafePointer<CChar>? = nil
        let result2 = table.__lookupUnsafe(key3, &foundKey2)
        #expect(foundKey2 == nil, "found_key_out should be nil for miss")
        #expect(result2 == nil)
    }

    @Test("string_hash produces non-zero results")
    @available(iOS 16.4, *)
    func stringHashFunction() {
        let hash1 = "hello".withCString { util.test_string_hash($0) }
        let hash2 = "world".withCString { util.test_string_hash($0) }
        let hash3 = "hello".withCString { util.test_string_hash($0) }

        #expect(hash1 != 0, "Hash should be non-zero for non-empty string")
        #expect(hash2 != 0, "Hash should be non-zero for non-empty string")
        #expect(hash1 == hash3, "Same string should produce same hash")
        #expect(hash1 != hash2, "Different strings should likely produce different hashes")
    }

    // MARK: - Pointer table tests (additional coverage)

    @Test("Pointer table: lookup with found_key_out")
    @available(iOS 16.4, *)
    func pointerTableLookupFoundKeyOut() {
        let table = util.UntypedTable.create()
        defer {
            util.UntypedTable.destroy(table)
        }

        var key = 42
        var value = 100
        withUnsafePointer(to: &key) { k in
            withUnsafePointer(to: &value) { v in
                _ = table.insert(k, v)
            }
        }

        // Lookup with found_key_out on pointer table
        var foundKey: UnsafeRawPointer? = nil
        withUnsafePointer(to: &key) { k in
            _ = table.__lookupUnsafe(k, &foundKey)
        }
        #expect(foundKey != nil, "found_key_out should be set on match")

        // Miss case
        var otherKey = 999
        var foundKey2: UnsafeRawPointer? = nil
        withUnsafePointer(to: &otherKey) { k in
            _ = table.__lookupUnsafe(k, &foundKey2)
        }
        #expect(foundKey2 == nil, "found_key_out should be nil for miss")
    }

    @Test("Grow buckets should not lose nodes")
    @available(iOS 16.4, *)
    func growBucketsPreservesAllNodes() {
        let table = util.UntypedTable.create()
        defer {
            util.UntypedTable.destroy(table)
        }

        // Initial bucket_mask_width is 4 (16 buckets)
        // Growth happens when count + 1 > 4 << bucket_mask_width
        // So growth happens at count > 64 for first growth
        // Insert enough items to trigger multiple growths
        let itemCount = 200
        var keys: [Int] = Array(0..<itemCount)

        for i in 0..<keys.count {
            withUnsafePointer(to: &keys[i]) { keyPointer in
                let inserted = table.insert(keyPointer, keyPointer)
                #expect(inserted == true, "Insert \(i) should succeed")
            }
        }

        #expect(table.count() == UInt64(itemCount))

        // Verify all items can be found
        for i in 0..<keys.count {
            withUnsafePointer(to: &keys[i]) { keyPointer in
                let found = table.__lookupUnsafe(keyPointer, nil)
                #expect(found != nil, "Key \(i) should be found after growth")
            }
        }

        // Count via for_each should match
        var iterationCount = 0
        table.for_each({ _, _, context in
            let countPtr = context.assumingMemoryBound(to: Int.self)
            countPtr.pointee += 1
        }, &iterationCount)

        #expect(iterationCount == itemCount, "for_each should visit all \(itemCount) items")
    }
}
