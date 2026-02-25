//
//  CFPtrTests.swift
//  UtilitiesTests

import Utilities
import Testing

@Suite("cf_ptr tests")
struct CFPtrTests {

    @Test("Default construction is null")
    @available(iOS 16.4, *)
    func defaultConstruction() {
        let helper = util.CFPtrTestHelper.create()
        defer {
            util.CFPtrTestHelper.destroy(helper)
        }

        #expect(helper.has_value() == false)
        #expect(helper.data_length() == -1)
        #expect(helper.retain_count() == 0)
    }

    @Test("Store and retrieve CFData")
    @available(iOS 16.4, *)
    func storeAndRetrieve() {
        let bytes: [UInt8] = [1, 2, 3, 4, 5]
        let helper = bytes.withUnsafeBufferPointer { buf in
            util.CFPtrTestHelper.create(buf.baseAddress, Int(buf.count))
        }
        defer {
            util.CFPtrTestHelper.destroy(helper)
        }

        #expect(helper.has_value() == true)
        #expect(helper.data_length() == 5)
        #expect(helper.retain_count() >= 1)
    }

    @Test("Reset clears value")
    @available(iOS 16.4, *)
    func resetClears() {
        let bytes: [UInt8] = [10, 20]
        let helper = bytes.withUnsafeBufferPointer { buf in
            util.CFPtrTestHelper.create(buf.baseAddress, Int(buf.count))
        }
        defer {
            util.CFPtrTestHelper.destroy(helper)
        }

        try! #require(helper.has_value() == true)

        helper.reset()

        #expect(helper.has_value() == false)
        #expect(helper.data_length() == -1)
    }

    @Test("Reset with new data replaces value")
    @available(iOS 16.4, *)
    func resetWithNewData() {
        let bytes: [UInt8] = [1, 2, 3]
        let helper = bytes.withUnsafeBufferPointer { buf in
            util.CFPtrTestHelper.create(buf.baseAddress, Int(buf.count))
        }
        defer {
            util.CFPtrTestHelper.destroy(helper)
        }

        #expect(helper.data_length() == 3)

        let newBytes: [UInt8] = [10, 20, 30, 40, 50, 60]
        newBytes.withUnsafeBufferPointer { buf in
            helper.reset_with(buf.baseAddress, Int(buf.count))
        }

        #expect(helper.has_value() == true)
        #expect(helper.data_length() == 6)
    }

    @Test("Copy creates independent ownership")
    @available(iOS 16.4, *)
    func copyCreatesIndependentOwnership() {
        let bytes: [UInt8] = [1, 2, 3]
        let original = bytes.withUnsafeBufferPointer { buf in
            util.CFPtrTestHelper.create(buf.baseAddress, Int(buf.count))
        }
        defer {
            util.CFPtrTestHelper.destroy(original)
        }

        let retainCountBefore = original.retain_count()

        let copied = original.copy_to_new()
        defer {
            util.CFPtrTestHelper.destroy(copied)
        }

        // Both should hold a value
        #expect(original.has_value() == true)
        #expect(copied.has_value() == true)

        // Both should see the same data
        #expect(original.data_length() == 3)
        #expect(copied.data_length() == 3)

        // Retain count should have increased
        #expect(original.retain_count() > retainCountBefore)
    }

    @Test("Move transfers ownership")
    @available(iOS 16.4, *)
    func moveTransfersOwnership() {
        let bytes: [UInt8] = [1, 2, 3, 4]
        let source = bytes.withUnsafeBufferPointer { buf in
            util.CFPtrTestHelper.create(buf.baseAddress, Int(buf.count))
        }
        defer {
            util.CFPtrTestHelper.destroy(source)
        }

        try! #require(source.has_value() == true)

        let dest = source.move_to_new()
        defer {
            util.CFPtrTestHelper.destroy(dest)
        }

        // Source should be null after move
        #expect(source.has_value() == false)

        // Destination should hold the value
        #expect(dest.has_value() == true)
        #expect(dest.data_length() == 4)
    }
}
