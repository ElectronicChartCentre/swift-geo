//
//  File.swift
//  swift-geo
//

import Foundation

public struct MultiCoordinateSequence: CoordinateSequence {
    
    public let css: [any CoordinateSequence]
    public let startIndex: Int
    public let endIndex: Int
    private let allCoordinates: [any Coordinate]
    
    public init(_ css: [any CoordinateSequence]) {
        self.css = css
        
        // do something smarter?
        var allCoordinates: [any Coordinate] = []
        for cs in css {
            for c in cs {
                allCoordinates.append(c)
            }
        }
        self.allCoordinates = allCoordinates

        self.startIndex = 0
        self.endIndex = allCoordinates.count
    }
    
    public static func create(_ css: [any CoordinateSequence]) -> (any CoordinateSequence) {
        
        if css.count == 1, let first = css.first {
            return first
        }
        
        return MultiCoordinateSequence(css)
    }
    
    public func index(after i: Int) -> Int {
        return allCoordinates.index(after: i)
    }
    
    public subscript(_ index: Int) -> any Coordinate {
        return allCoordinates[index]
    }
    
    public func transform(_ transform: (any Coordinate) -> any Coordinate) -> MultiCoordinateSequence {
        var newCss: [any CoordinateSequence] = []
        for cs in css {
            newCss.append(cs.transform(transform))
        }
        return MultiCoordinateSequence(newCss)
    }
    
}
