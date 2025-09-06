//
//  Focus.swift
//  OpenAttributeGraph
//
//  Audited for RELEASE_2021
//  Status: Complete

/// A rule that focuses on a specific property of another attribute using KeyPath.
///
/// `Focus` provides a way to create attributes that automatically track a specific property of another attribute. It uses Swift's KeyPath system to create a focused view of part of a larger data structure.
///
///     struct Person {
///         let name: String
///         let age: Int
///     }
///
///     @Attribute var person = Person(name: "Alice", age: 30)
///     let nameAttribute = Attribute(Focus(root: $person, keyPath: \.name))
///     // nameAttribute automatically updates when person.name changes
///
/// Focus is commonly used internally by OpenAttributeGraph's dynamic member lookup system to create property-specific attributes.
///
/// ## Key Features
///
/// - KeyPath-based focusing: Use any Swift KeyPath to focus on specific properties
/// - Automatic updates: Changes to the focused property automatically propagate
/// - Type safety: Full compile-time type checking for focused properties
/// - Efficient tracking: Only tracks changes to the specific focused property
///
/// ## Usage Pattern
///
/// Focus is ideal for:
/// - Creating focused views of complex data structures
/// - Implementing dynamic member lookup for attributes
/// - Breaking down large objects into smaller, more manageable attribute pieces
/// - Selective observation of specific properties
@frozen
public struct Focus<Root, Value>: Rule, CustomStringConvertible {
    public var root: Attribute<Root>
    public var keyPath: KeyPath<Root, Value>
    
    public init(root: Attribute<Root>, keyPath: KeyPath<Root, Value>) {
        self.root = root
        self.keyPath = keyPath
    }

    public var value: Value { root.value[keyPath: keyPath] }

    public static var flags: Flags { [] }

    public var description: String { "• \(Metadata(Value.self).description)" }
}
