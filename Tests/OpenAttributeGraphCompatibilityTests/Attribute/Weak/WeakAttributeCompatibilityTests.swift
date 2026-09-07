//
//  WeakAttributeCompatibilityTests.swift
//  OpenAttributeGraphCompatibilityTests

import Testing

#if canImport(Darwin)
@MainActor
@Suite(.enabled(if: compatibilityTestEnabled), .graphScope)
struct WeakAttributeCompatibilityTests {
    @Test
    func initTest() {
        _ = WeakAttribute<Int>()
        _ = WeakAttribute<Int>(nil)
        let attr = Attribute(value: 0)
        _ = WeakAttribute(attr)
    }

    @Test
    func base() {
        let first = Attribute(value: 1)
        let second = Attribute(value: 2)
        var weak = WeakAttribute(first)
        #expect(weak.base == AnyWeakAttribute(first.identifier))

        weak.base = AnyWeakAttribute(second.identifier)
        #expect(weak.attribute == second)
        #expect(weak.wrappedValue == 2)

        weak.base = AnyWeakAttribute(nil)
        #expect(weak.attribute == nil)
        #expect(weak.wrappedValue == nil)
    }
}
#endif
