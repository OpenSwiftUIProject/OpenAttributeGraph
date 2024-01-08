//
//  UniqueIDTests.swift
//  
//
//  Created by Kyle on 2023/10/9.
//

import XCTest
#if OPENGRAPH_COMPATIBILITY_TEST
import AttributeGraph
#else
import OpenGraph
#endif

final class UniqueIDTests: XCTestCase {
    func testUniqueID() throws {
        XCTAssertEqual(makeUniqueID(), 1)
        XCTAssertEqual(makeUniqueID(), 2)
    }
}
