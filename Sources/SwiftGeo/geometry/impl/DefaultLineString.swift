//
//  File.swift
//  swift-geo
//

import Foundation

public struct DefaultLineString: LineString {
    
    public let coordinates: [Coordinate]
    
    public func isEmpty() -> Bool {
        return coordinates.isEmpty
    }
    
    public func isValid() -> Bool {
        return coordinates.count > 1
    }
    
    public func bbox() -> BoundingBox? {
        return DefaultBoundingBox.create(coordinates)
    }
    
    public func transform(_ transform: (Coordinate) -> Coordinate) -> DefaultLineString {
        var newCoords: [Coordinate] = []
        for coord in coordinates {
            newCoords.append(transform(coord))
        }
        return DefaultLineString(coordinates: newCoords)
    }
    
}
