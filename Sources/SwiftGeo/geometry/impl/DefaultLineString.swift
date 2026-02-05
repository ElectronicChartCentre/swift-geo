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
    
    public func length() -> Double {
        var length: Double = 0
        var prevCoordinate: Coordinate? = nil
        for coordinate in coordinates {
            if let prevCoordinate = prevCoordinate {
                length += prevCoordinate.distance2D(to: coordinate)
            }
            prevCoordinate = coordinate
        }
        return length
    }
    
    public func coordinate(at index: Int) -> Coordinate? {
        if index < 0 || index >= coordinates.count {
            return nil
        }
        return coordinates[index]
    }
    
}
