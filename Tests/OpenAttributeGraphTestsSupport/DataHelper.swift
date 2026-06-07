//
//  DataHelper.swift
//  OpenAttributeGraphTestsSupport

public struct Tuple<A, B> {
    public var first: A
    public var second: B

    public init(first: A, second: B) {
        self.first = first
        self.second = second
    }
}

extension Tuple: Sendable where A: Sendable, B: Sendable {}

public struct Triple<A, B, C> {
    public var first: A
    public var second: B
    public var third: C

    public init(first: A, second: B, third: C) {
        self.first = first
        self.second = second
        self.third = third
    }
}

extension Triple: Sendable where A: Sendable, B: Sendable, C: Sendable {}
