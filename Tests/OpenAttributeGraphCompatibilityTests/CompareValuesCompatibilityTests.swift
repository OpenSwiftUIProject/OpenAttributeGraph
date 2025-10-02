//
//  CompareValuesCompatibilityTests.swift
//  OpenAttributeGraphCompatibilityTests

import Testing

@Suite(.disabled(if: !compatibilityTestEnabled, "OAGCompareValues is not implemented"))
struct CompareValuesCompatibilityTests {
    @Test
    func intCompare() throws {
        #expect(compareValues(1, 1) == true)
        #expect(compareValues(1, 2) == false)
    }

    @Test
    func enumCompare() throws {
        enum A { case a, b }
        #expect(compareValues(A.a, A.a) == true)
        #expect(compareValues(A.a, A.b) == false)

        enum B { case a, b, c }
        let b = B.b
        withUnsafePointer(to: b) { p in
            p.withMemoryRebound(to: A.self, capacity: MemoryLayout<A>.size) { pointer in
                #expect(compareValues(pointer.pointee, A.b) == true)
            }
        }
        withUnsafePointer(to: b) { p in
            p.withMemoryRebound(to: A.self, capacity: MemoryLayout<A>.size) { pointer in
                #expect(compareValues(pointer.pointee, A.a) == false)
            }
        }
    }

    @Test
    func structCompare() throws {
        struct A1 {
            var a: Int
            var b: Bool
        }
        struct A2 {
            var a: Int
            var b: Bool
        }
        let a = A1(a: 1, b: true)
        let b = A1(a: 1, b: true)
        let c = A1(a: 1, b: false)
        #expect(compareValues(b, a) == true)
        #expect(compareValues(c, a) == false)
        let d = A2(a: 1, b: true)
        withUnsafePointer(to: d) { p in
            p.withMemoryRebound(to: A1.self, capacity: MemoryLayout<A1>.size) { pointer in
                #expect(compareValues(pointer.pointee, a) == true)
            }
        }
        withUnsafePointer(to: d) { p in
            p.withMemoryRebound(to: A1.self, capacity: MemoryLayout<A1>.size) { pointer in
                #expect(compareValues(pointer.pointee, c) == false)
            }
        }
    }


    //  Below is the graph to show the expected behavior of compareValues with different modes and types
    //  ┌──────────────────┬────────────────────┬──────────────────┬──────────────────┐
    //  │                  │ mode               │ Layout not ready │ Layout ready     │
    //  ├──────────────────┼────────────────────┼──────────────────┼──────────────────┤
    //  │                  │ bitwise            │ bitwise          │ bitwise          │
    //  │ PODEquatable     │ equatableUnlessPOD │ bitwise          │ bitwise          │
    //  │                  │ equatableAlways    │ bitwise          │ equatable        │
    //  ├──────────────────┼────────────────────┼──────────────────┼──────────────────┤
    //  │                  │ bitwise            │ bitwise          │ bitwise          │
    //  │ NonPODEquatable  │ equatableUnlessPOD │ bitwise          │ equatable        │
    //  │                  │ equatableAlways    │ bitwise          │ equatable        │
    //  └──────────────────┴────────────────────┴──────────────────┴──────────────────┘

    struct POD {
        var id: Int
    }

    struct PODEquatable: Equatable {
        var id: Int
        var v1: Int

        static func == (lhs: Self, rhs: Self) -> Bool {
            lhs.id == rhs.id && (lhs.v1 - rhs.v1) % 2 == 0
        }
    }

    struct PODEquatableTrue: Equatable {
        var id: Int

        static func == (lhs: Self, rhs: Self) -> Bool {
            true
        }
    }

    struct PODEquatableFalse: Equatable {
        var id: Int

        static func == (lhs: Self, rhs: Self) -> Bool {
            false
        }
    }

    struct NonPODEquatable: Equatable {
        init(id: Int, v1: Int) {
            self.id = id
            self.m = M(v: v1)
        }

        var id: Int
        var v1: Int { m.v }

        class M: Equatable {
            var v: Int
            init(v: Int) { self.v = v }

            static func == (lhs: M, rhs: M) -> Bool {
                lhs.v == rhs.v
            }
        }
        var m: M

        static func == (lhs: NonPODEquatable, rhs: NonPODEquatable) -> Bool {
            lhs.id == rhs.id && (lhs.v1 - rhs.v1) % 2 == 0
        }
    }

    @Test
    func bitwizeMode() async throws {
        let mode = ComparisonMode.bitwise
        #expect(compareValues(POD(id: 1), POD(id: 1), mode: mode) == true)
        #expect(compareValues(POD(id: 1), POD(id: 2), mode: mode) == false)
        #expect(compareValues(POD(id: 1), POD(id: 3), mode: mode) == false)
        #expect(compareValues(PODEquatable(id: 1, v1: 2), PODEquatable(id: 1, v1: 2), mode: mode) == true)
        #expect(compareValues(PODEquatable(id: 1, v1: 2), PODEquatable(id: 1, v1: 3), mode: mode) == false)
        #expect(compareValues(PODEquatable(id: 1, v1: 2), PODEquatable(id: 1, v1: 4), mode: mode) == false)
        #expect(compareValues(PODEquatableTrue(id: 1), PODEquatableTrue(id: 1), mode: mode) == true)
        #expect(compareValues(PODEquatableTrue(id: 1), PODEquatableTrue(id: 2), mode: mode) == false)
        #expect(compareValues(PODEquatableFalse(id: 1), PODEquatableFalse(id: 1), mode: mode) == true)
        #expect(compareValues(PODEquatableFalse(id: 1), PODEquatableFalse(id: 2), mode: mode) == false)
        #expect(compareValues(NonPODEquatable(id: 1, v1: 2), NonPODEquatable(id: 1, v1: 2), mode: mode) == false, "bitwize compare will fail since M is a class")
    }

    @Test
    func equatableUnlessPODMode() async throws {
        let mode = ComparisonMode.equatableUnlessPOD
        // layout is not ready, use bitwise copmare
        #expect(compareValues(POD(id: 1), POD(id: 1), mode: mode) == true)
        #expect(compareValues(POD(id: 1), POD(id: 2), mode: mode) == false)
        #expect(compareValues(POD(id: 1), POD(id: 3), mode: mode) == false)
        #expect(compareValues(PODEquatable(id: 1, v1: 2), PODEquatable(id: 1, v1: 2), mode: mode) == true)
        #expect(compareValues(PODEquatable(id: 1, v1: 2), PODEquatable(id: 1, v1: 3), mode: mode) == false)
        #expect(compareValues(PODEquatable(id: 1, v1: 2), PODEquatable(id: 1, v1: 4), mode: mode) == false)
        #expect(compareValues(PODEquatableTrue(id: 1), PODEquatableTrue(id: 1), mode: mode) == true)
        #expect(compareValues(PODEquatableTrue(id: 1), PODEquatableTrue(id: 2), mode: mode) == false)
        #expect(compareValues(PODEquatableFalse(id: 1), PODEquatableFalse(id: 1), mode: mode) == true)
        #expect(compareValues(PODEquatableFalse(id: 1), PODEquatableFalse(id: 2), mode: mode) == false)
        #expect(compareValues(NonPODEquatable(id: 1, v1: 2), NonPODEquatable(id: 1, v1: 2), mode: mode) == false)
        #expect(compareValues(NonPODEquatable(id: 1, v1: 2), NonPODEquatable(id: 1, v1: 3), mode: mode) == false)
        #expect(compareValues(NonPODEquatable(id: 1, v1: 2), NonPODEquatable(id: 1, v1: 4), mode: mode) == false)

        try await Task.sleep(for: .seconds(1))

        // layout is ready, use Equatable copmare only for non POD type when avaiable
        #expect(compareValues(POD(id: 1), POD(id: 1), mode: mode) == true)
        #expect(compareValues(POD(id: 1), POD(id: 2), mode: mode) == false)
        #expect(compareValues(POD(id: 1), POD(id: 3), mode: mode) == false)

        #expect(compareValues(PODEquatable(id: 1, v1: 2), PODEquatable(id: 1, v1: 2), mode: mode) == true)
        #expect(compareValues(PODEquatable(id: 1, v1: 2), PODEquatable(id: 1, v1: 3), mode: mode) == false)
        #expect(compareValues(PODEquatable(id: 1, v1: 2), PODEquatable(id: 1, v1: 4), mode: mode) == false, "POD type, use bitwise compare")

        #expect(compareValues(PODEquatableTrue(id: 1), PODEquatableTrue(id: 1), mode: mode) == true)
        #expect(compareValues(PODEquatableTrue(id: 1), PODEquatableTrue(id: 2), mode: mode) == false, "POD type, use bitwise compare")
        #expect(compareValues(PODEquatableFalse(id: 1), PODEquatableFalse(id: 1), mode: mode) == true, "POD type, use bitwise compare")
        #expect(compareValues(PODEquatableFalse(id: 1), PODEquatableFalse(id: 2), mode: mode) == false)

        #expect(compareValues(NonPODEquatable(id: 1, v1: 2), NonPODEquatable(id: 1, v1: 2), mode: mode) == true, "Non POD type, use Equatable compare")
        #expect(compareValues(NonPODEquatable(id: 1, v1: 2), NonPODEquatable(id: 1, v1: 3), mode: mode) == false)
        #expect(compareValues(NonPODEquatable(id: 1, v1: 2), NonPODEquatable(id: 1, v1: 4), mode: mode) == true, "Non POD type, use Equatable compare")
    }

    @Test
    func equatableAlwaysMode() async throws {
        let mode = ComparisonMode.equatableAlways
        // When layout is not ready, the same as bitwize
        #expect(compareValues(POD(id: 1), POD(id: 1), mode: mode) == true)
        #expect(compareValues(POD(id: 1), POD(id: 2), mode: mode) == false)
        #expect(compareValues(POD(id: 1), POD(id: 3), mode: mode) == false)
        #expect(compareValues(PODEquatable(id: 1, v1: 2), PODEquatable(id: 1, v1: 2), mode: mode) == true)
        #expect(compareValues(PODEquatable(id: 1, v1: 2), PODEquatable(id: 1, v1: 3), mode: mode) == false)
        #expect(compareValues(PODEquatable(id: 1, v1: 2), PODEquatable(id: 1, v1: 4), mode: mode) == false)
        #expect(compareValues(PODEquatableTrue(id: 1), PODEquatableTrue(id: 1), mode: mode) == true)
        #expect(compareValues(PODEquatableTrue(id: 1), PODEquatableTrue(id: 2), mode: mode) == false)
        #expect(compareValues(PODEquatableFalse(id: 1), PODEquatableFalse(id: 1), mode: mode) == true)
        #expect(compareValues(PODEquatableFalse(id: 1), PODEquatableFalse(id: 2), mode: mode) == false)
        #expect(compareValues(NonPODEquatable(id: 1, v1: 2), NonPODEquatable(id: 1, v1: 2), mode: mode) == false)
        #expect(compareValues(NonPODEquatable(id: 1, v1: 2), NonPODEquatable(id: 1, v1: 3), mode: mode) == false)
        #expect(compareValues(NonPODEquatable(id: 1, v1: 2), NonPODEquatable(id: 1, v1: 4), mode: mode) == false)

        try await Task.sleep(for: .seconds(1))

        // layout is ready, Equatable is used when avaiable
        #expect(compareValues(POD(id: 1), POD(id: 1), mode: mode) == true)
        #expect(compareValues(POD(id: 1), POD(id: 2), mode: mode) == false)
        #expect(compareValues(POD(id: 1), POD(id: 3), mode: mode) == false)

        #expect(compareValues(PODEquatable(id: 1, v1: 2), PODEquatable(id: 1, v1: 2), mode: mode) == true)
        #expect(compareValues(PODEquatable(id: 1, v1: 2), PODEquatable(id: 1, v1: 3), mode: mode) == false)
        #expect(compareValues(PODEquatable(id: 1, v1: 2), PODEquatable(id: 1, v1: 4), mode: mode) == true, "use Equatable compare")

        #expect(compareValues(PODEquatableTrue(id: 1), PODEquatableTrue(id: 1), mode: mode) == true)
        #expect(compareValues(PODEquatableTrue(id: 1), PODEquatableTrue(id: 2), mode: mode) == true, "use Equatable compare")
        #expect(compareValues(PODEquatableFalse(id: 1), PODEquatableFalse(id: 1), mode: mode) == false, "use Equatable compare")
        #expect(compareValues(PODEquatableFalse(id: 1), PODEquatableFalse(id: 2), mode: mode) == false)

        #expect(compareValues(NonPODEquatable(id: 1, v1: 2), NonPODEquatable(id: 1, v1: 2), mode: mode) == true, "use Equatable compare")
        #expect(compareValues(NonPODEquatable(id: 1, v1: 2), NonPODEquatable(id: 1, v1: 3), mode: mode) == false)
        #expect(compareValues(NonPODEquatable(id: 1, v1: 2), NonPODEquatable(id: 1, v1: 4), mode: mode) == true, "use Equatable compare")
    }
}
