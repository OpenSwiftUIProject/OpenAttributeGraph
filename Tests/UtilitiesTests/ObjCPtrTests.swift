//
//  ObjCPtrTests.swift
//  UtilitiesTests

import Utilities
import Testing

@Suite("objc_ptr tests")
struct ObjCPtrTests {

    @Test("Default construction is null")
    @available(iOS 16.4, *)
    func defaultConstruction() {
        let helper = util.ObjCPtrTestHelper.create()
        defer {
            util.ObjCPtrTestHelper.destroy(helper)
        }

        #expect(helper.has_value() == false)
    }

    @Test("Store NSObject")
    @available(iOS 16.4, *)
    func storeNSObject() {
        let helper = util.ObjCPtrTestHelper.create_with_nsobject()
        defer {
            util.ObjCPtrTestHelper.destroy(helper)
        }

        #expect(helper.has_value() == true)
    }

    @Test("Reset clears value")
    @available(iOS 16.4, *)
    func resetClears() {
        let helper = util.ObjCPtrTestHelper.create_with_nsobject()
        defer {
            util.ObjCPtrTestHelper.destroy(helper)
        }

        try! #require(helper.has_value() == true)

        helper.reset()

        #expect(helper.has_value() == false)
    }

    @Test("Store after default construction")
    @available(iOS 16.4, *)
    func storeAfterDefault() {
        let helper = util.ObjCPtrTestHelper.create()
        defer {
            util.ObjCPtrTestHelper.destroy(helper)
        }

        #expect(helper.has_value() == false)

        helper.store_nsobject()

        #expect(helper.has_value() == true)
    }

    @Test("Copy creates independent ownership")
    @available(iOS 16.4, *)
    func copyCreatesIndependentOwnership() {
        let original = util.ObjCPtrTestHelper.create_with_nsobject()
        defer {
            util.ObjCPtrTestHelper.destroy(original)
        }

        let copied = original.copy_to_new()
        defer {
            util.ObjCPtrTestHelper.destroy(copied)
        }

        // Both should hold a value
        #expect(original.has_value() == true)
        #expect(copied.has_value() == true)

        // Both should point to the same object
        #expect(original.same_object(copied) == true)
    }

    @Test("Move transfers ownership")
    @available(iOS 16.4, *)
    func moveTransfersOwnership() {
        let source = util.ObjCPtrTestHelper.create_with_nsobject()
        defer {
            util.ObjCPtrTestHelper.destroy(source)
        }

        try! #require(source.has_value() == true)

        let dest = source.move_to_new()
        defer {
            util.ObjCPtrTestHelper.destroy(dest)
        }

        // Source should be null after move
        #expect(source.has_value() == false)

        // Destination should hold the value
        #expect(dest.has_value() == true)
    }
}
