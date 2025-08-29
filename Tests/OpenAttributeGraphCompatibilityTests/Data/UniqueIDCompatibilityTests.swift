//
//  UniqueIDCompatibilityTests.swift
//  OpenAttributeGraphCompatibilityTests

import Testing

struct UniqueIDCompatibilityTests {
    @Test
    func uniqueID() throws {
        let initialID = makeUniqueID()
        #expect(makeUniqueID() == initialID + 1)
    }
}
