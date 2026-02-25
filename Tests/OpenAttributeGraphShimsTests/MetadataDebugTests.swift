//
//  MetadataDebugTests.swift
//  OpenAttributeGraphShimsTests

@_spi(Debug) import OpenAttributeGraphShims
import Testing

#if canImport(UIKit)
import UIKit

private typealias PlatformView = UIView
#elseif canImport(AppKit)
import AppKit

private typealias PlatformView = NSView
#endif

@Suite(.disabled(if: !attributeGraphEnabled, "forEachField is not implemented for OAG"))
struct MetadataDebugTests {
    struct Demo1 {
        var a: Int = .zero
        var b: Double = .zero
    }

    class Demo2 {
        var a: Int = .zero
        var b: Double = .zero
    }

    @Test
    func layout() {
        #expect(Metadata(Demo1.self).layoutDescription == #"""
        struct Demo1 {
        \#tvar a: Int // offset = 0x0
        \#tvar b: Double // offset = 0x8
        }

        """#)

        #expect(Metadata(Demo2.self).layoutDescription == #"""
        class Demo2 {
        \#tvar a: Int // offset = 0x10
        \#tvar b: Double // offset = 0x18
        }

        """#)
    }

    #if canImport(UIKit) || canImport(AppKit)
    @Test
    func unknownFields() {
        class DemoView: PlatformView {
            var a: Int = .zero
            var b: Double = .zero
        }
        let layoutDescription = Metadata(DemoView.self).layoutDescription.split(separator: "\n").map(String.init)
        #expect(layoutDescription[0] == "class DemoView {")
        #expect(layoutDescription[1].contains("var a: Int // offset = "))
        #expect(layoutDescription[2].contains("var b: Double // offset = "))
        #expect(layoutDescription[3] == "}")
    }
    #endif
}

extension Int {
    private var hex: String {
        "0x\(String(format: "%X", self))"
    }
}
