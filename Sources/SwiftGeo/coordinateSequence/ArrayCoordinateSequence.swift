//
//  File.swift
//  swift-geo
//

import Foundation

public struct ArrayCoordinateSequence: CoordinateSequence {
    
    private let coordinates: [any Coordinate]
    public let startIndex: Int
    public let endIndex: Int

    public let ref: (any Hashable & Sendable)?
    
    public init(_ coordinates: [any Coordinate], ref: (any Hashable & Sendable)? = nil) {
        self.coordinates = coordinates
        self.startIndex = 0
        self.endIndex = coordinates.count
        self.ref = ref
    }
    
    public func index(after i: Int) -> Int {
        return coordinates.index(after: i)
    }
    
    public subscript(index: Int) -> any Coordinate {
        return coordinates[index]
    }
    
    public func makeIterator() -> IndexingIterator<[any Coordinate]> {
        return coordinates.makeIterator()
    }
    
    public func transform(_ transform: (any Coordinate) -> any Coordinate) -> ArrayCoordinateSequence {
        var transformedCoordinates: [any Coordinate] = []
        for coord in coordinates {
            transformedCoordinates.append(transform(coord))
        }
        return ArrayCoordinateSequence(transformedCoordinates, ref: ref)
    }
    
}
