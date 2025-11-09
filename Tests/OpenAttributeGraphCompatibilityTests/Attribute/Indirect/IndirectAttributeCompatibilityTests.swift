//
//  IndirectAttributeCompatibilityTests.swift
//  OpenAttributeGraphCompatibilityTests

import Testing

#if canImport(Darwin)
@MainActor
@Suite(.disabled(if: !compatibilityTestEnabled, "IndirectAttribute is not implemented"), .graphScope)
struct IndirectAttributeCompatibilityTests {
    @Test
    func basic() {
        let source = Attribute(value: 0)
        let indirect = IndirectAttribute(source: source)
        #expect(indirect.attribute.identifier == indirect.identifier)
        #expect(indirect.identifier != source.identifier)
        #expect(indirect.source.identifier == source.identifier)
        #expect(indirect.dependency == .init(rawValue: 0))
    }
    
    @Test
    func resetSource() {
        let source1 = Attribute(value: 0)
        let indirect = IndirectAttribute(source: source1)
        #expect(indirect.source.identifier == source1.identifier)
        
        let source2 = Attribute(value: 0)
        indirect.source = source2
        #expect(indirect.source.identifier == source2.identifier)
        
        indirect.resetSource()
        #expect(indirect.source.identifier == source1.identifier)
    }
}
#endif
