//
//  AttributeBodyVisitor.swift
//  OpenAttributeGraph
//
//  Status: WIP

public protocol AttributeBodyVisitor {
    mutating func visit<Body: _AttributeBody>(body: UnsafePointer<Body>)
}
