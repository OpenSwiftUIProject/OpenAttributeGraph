//
//  AnyWeakAttributeCompatibilityTests.swift
//  OpenAttributeGraphCompatibilityTests

import Testing

#if canImport(Darwin)
@MainActor
@Suite(.enabled(if: compatibilityTestEnabled), .graphScope)
struct AnyWeakAttributeCompatibilityTests {
    @Test
    func basic() {
        let w1 = AnyWeakAttribute(nil)
        let w2 = AnyWeakAttribute(WeakAttribute<Void>(nil))
        #expect(w1.attribute == nil)
        #expect(w2.attribute == nil)
        #expect(w2.unsafeCast(to: Void.self) == WeakAttribute(base: w2))
    }

    @Test
    func hashable() {
        let w1 = AnyWeakAttribute(nil)
        let w2 = AnyWeakAttribute(WeakAttribute<Void>(nil))
        #expect(w1 == w2)
        _ = w1.hashValue
    }

    @Test
    func description() {
        let attr = Attribute<Int>(value: 1)
        if compatibilityTestEnabled {
            #expect(AnyWeakAttribute(attr.identifier).description != "nil")
        }
        #expect(AnyWeakAttribute(nil).description == "nil")
    }

    @Test
    func dict() {
        let w1 = AnyWeakAttribute(nil)
        let w2 = AnyWeakAttribute(Attribute(value: 0).identifier)
        let dict: [AnyWeakAttribute: Int] = [
            w1: 1,
            w2: 2,
        ]
        #expect(dict[w1] == 1)
        #expect(dict[w2] == 2)
    }
}
#endif
