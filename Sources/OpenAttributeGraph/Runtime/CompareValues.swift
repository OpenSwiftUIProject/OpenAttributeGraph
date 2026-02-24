//
//  CompareValues.swift
//  OpenAttributeGraph
//
//  Audited for 3.2.1
//  Status: Complete

public import OpenAttributeGraphCxx

@_silgen_name("OAGCompareValues")
private func OAGCompareValues(
    lhs: UnsafeRawPointer,
    rhs: UnsafeRawPointer,
    type: Any.Type,
    options: ComparisonOptions
) -> Bool

/// Compares two values using the specified comparison mode.
public func compareValues<Value>(_ lhs: Value, _ rhs: Value, mode: ComparisonMode = .equatableAlways) -> Bool {
    compareValues(lhs, rhs, options: [.init(mode: mode), .copyOnWrite])
}

/// Compares two values using the specified comparison options.
public func compareValues<Value>(_ lhs: Value, _ rhs: Value, options: ComparisonOptions) -> Bool {
    withUnsafePointer(to: lhs) { p1 in
        withUnsafePointer(to: rhs) { p2 in
            OAGCompareValues(lhs: p1, rhs: p2, type: Value.self, options: options)
        }
    }
}

extension ComparisonOptions {
    public init(mode: ComparisonMode) {
        self.init(rawValue: numericCast(mode.rawValue))
    }
}
