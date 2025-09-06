//
//  HashTableTests.swift
//  OpenAttributeGraphCxxTests

import OpenAttributeGraphCxx_Private.Util
import Testing

struct HashTableTests {
    @Test
    func untypedTableBasicOperations() {
        let table = util.UntypedTable.create()
        defer { util.UntypedTable.destroy(table) }
        
        // Test empty table
        #expect(table.empty())
        #expect(table.count() == 0)
        
        // Test insert operations using stable pointers
        var key1: Int = 42
        var value1: Int = 100
        
        let keyPtr = withUnsafePointer(to: &key1) { $0 }
        let valuePtr = withUnsafePointer(to: &value1) { $0 }
        
        let inserted = table.insert(keyPtr, valuePtr)
        #expect(inserted)
        #expect(!table.empty())
        #expect(table.count() == 1)
    }
    
    @Test
    func untypedTableMultipleEntries() {
        let table = util.UntypedTable.create()
        defer { util.UntypedTable.destroy(table) }
        
        // Insert multiple key-value pairs using stable pointers
        var keys: [Int] = []
        var values: [Int] = []
        
        for i in 0..<5 {
            keys.append(i + 1)
            values.append((i + 1) * 10)
        }
        
        for i in 0..<5 {
            let keyPtr = withUnsafePointer(to: &keys[i]) { $0 }
            let valuePtr = withUnsafePointer(to: &values[i]) { $0 }
            let inserted = table.insert(keyPtr, valuePtr)
            #expect(inserted)
        }
        
        #expect(table.count() == 5)
    }
    
    @Test
    func untypedTableRemoval() {
        let table = util.UntypedTable.create()
        defer { util.UntypedTable.destroy(table) }
        
        // Use heap allocated values to ensure stable pointers
        let key1Box = UnsafeMutablePointer<Int>.allocate(capacity: 1)
        let value1Box = UnsafeMutablePointer<Int>.allocate(capacity: 1)
        let key2Box = UnsafeMutablePointer<Int>.allocate(capacity: 1)
        let value2Box = UnsafeMutablePointer<Int>.allocate(capacity: 1)
        
        defer {
            key1Box.deallocate()
            value1Box.deallocate()
            key2Box.deallocate()
            value2Box.deallocate()
        }
        
        key1Box.pointee = 1
        value1Box.pointee = 10
        key2Box.pointee = 2
        value2Box.pointee = 20
        
        let inserted1 = table.insert(key1Box, value1Box)
        let inserted2 = table.insert(key2Box, value2Box)
        #expect(inserted1)
        #expect(inserted2)
        #expect(table.count() == 2)
        
        // Remove one entry
        let removed1 = table.remove(key1Box)
        #expect(removed1)
        #expect(table.count() == 1)
        
        // Remove remaining entry
        let removed2 = table.remove(key2Box)
        #expect(removed2)
        #expect(table.count() == 0)
        #expect(table.empty())
        
        // Try to remove from empty table
        let removedFromEmpty = table.remove(key1Box)
        #expect(!removedFromEmpty)
        #expect(table.count() == 0)
    }
}
