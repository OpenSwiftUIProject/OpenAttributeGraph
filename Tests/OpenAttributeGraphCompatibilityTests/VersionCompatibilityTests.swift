//
//  VersionCompatibilityTests.swift
//  OpenAttributeGraphCompatibilityTests

import Testing
import Numerics

struct VersionTests {
    @Test
    func versionNumber() async {
        await confirmation { confirm in
            #if OPENATTRIBUTEGRAPH
            switch Int32(OPENATTRIBUTEGRAPH_RELEASE) {
                case OPENATTRIBUTEGRAPH_RELEASE_2021:
                    #expect(OpenAttributeGraphVersionNumber.isApproximatelyEqual(to: 3.2))
                    #expect(OAGVersion == 0x20014)
                    confirm()
                case OPENATTRIBUTEGRAPH_RELEASE_2024:
                    #expect(OpenAttributeGraphVersionNumber.isApproximatelyEqual(to: 6.0))
                    #expect(OAGVersion == 0x2001e)
                    confirm()
                default:
                    break
            }
            #else
            switch Int32(ATTRIBUTEGRAPH_RELEASE) {
                case ATTRIBUTEGRAPH_RELEASE_2021:
                    #expect(AGVersion == 0x20014)
                    confirm()
                case ATTRIBUTEGRAPH_RELEASE_2024:
                    #expect(AGVersion == 0x2001e)
                    confirm()
                default:
                    break
            }
            #endif
        }
    }
}
