//
//  TableTests.swift
//  OpenAttributeGraphCxxTests

#if canImport(Darwin) // table() is not implemented on Linux yet.
import OpenAttributeGraphCxx_Private.Data
import Testing

struct TableTests {
    @Test
    func table() {
        let table = OAG.data.table()
        table.print()
    }
}
#endif
