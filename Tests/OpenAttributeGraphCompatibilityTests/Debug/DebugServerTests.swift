//
//  DebugServerTests.swift
//  OpenAttributeGraphCompatibilityTests

#if canImport(Darwin)
import CoreFoundation
import Foundation
import Testing

@MainActor
struct DebugServerTests {
    @Test
    func testMode0() {
        #expect(DebugServer.start(mode: []) == nil)
        #expect(DebugServer.copyURL() == nil)
    }

    // To make AG start debugServer, we need to pass internal_diagnostics check.
    // In debug mode, we can breakpoint on `_ZN2AG11DebugServer5startEj` and
    // executable `reg write w0 1` after `internal_diagnostics` call.
    // Or we can disable SIP on the target darwinOS and run `sudo sysctl kern.osvariant_status=xx` to workaround.
    // Or you can add `breakpoint set -n os_variant_has_internal_diagnostics -C "thread return 1"`
    // to your lldbinit or run it before AGDebugServerStart call.
    @Test(.disabled(if: compatibilityTestEnabled, "Skip on AG on CI due to internal_diagnostics check"))
    func testMode1() throws {
        let _ = try #require(DebugServer.start(mode: [.valid]))
        let url = try #require(DebugServer.copyURL()) as URL
        #expect(url.scheme == "graph")
        let host = try #require(url.host)
        #expect(host == "127.0.0.1")
        DebugServer.run(timeout: 1)
        DebugServer.stop()
    }

    @Test(.disabled(if: compatibilityTestEnabled, "Skip on AG on CI due to internal_diagnostics check"))
    func testMode3() throws {
        let _ = try #require(DebugServer.start(mode: [.valid, .networkInterface]))
        let url = try #require(DebugServer.copyURL()) as URL
        #expect(url.scheme == "graph")
        let host = try #require(url.host)
        #expect(host != "127.0.0.1")
        #expect(host.hasPrefix("192.168"))
        DebugServer.run(timeout: 1)
        DebugServer.stop()
    }
}
#endif
