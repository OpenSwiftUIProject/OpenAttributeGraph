//
//  Graph+Debug.swift
//  OpenAttributeGraphShims

#if canImport(Darwin)

#if OPENATTRIBUTEGRAPH_COMPUTE
extension Graph {
    public static var descriptionFormatDictionary: CFString {
        "graph/dict" as CFString
    }

    public static var descriptionFormatDot: CFString {
        "graph/dot" as CFString
    }

    public static var descriptionAllGraphs: CFString {
        "all_graphs" as CFString
    }
}
#endif

import Foundation

@_spi(Debug)
extension Graph {
    public var dict: [String: Any]? {
        let options = [
            DescriptionOption.format: Graph.descriptionFormatDictionary
        ] as NSDictionary
        guard let description = Graph.description(nil, options: options) else {
            return nil
        }
        guard let dictionary = description as? NSDictionary else {
            return nil
        }
        return dictionary as? [String: Any]
    }

    // style:
    // - bold: empty input/output edge
    // - dashed: indirect or has no value
    // color:
    // - red: is_changed
    public var dot: String? {
        let options = [
            DescriptionOption.format: Graph.descriptionFormatDot
        ] as NSDictionary
        guard let description = Graph.description(self, options: options)
        else {
            return nil
        }
        return description as? String
    }
}

#endif
