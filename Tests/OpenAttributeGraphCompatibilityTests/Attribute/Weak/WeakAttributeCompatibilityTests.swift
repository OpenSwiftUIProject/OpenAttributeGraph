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
}
#endif
