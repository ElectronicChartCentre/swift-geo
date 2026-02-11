//
//  File.swift
//  swift-geo
//

import Foundation

public struct DefaultLineString: LineString {
    
    public let coordinates: [any Coordinate]
    
    public func isEmpty() -> Bool {
        return coordinates.isEmpty
    }
    
    public func isValid() -> Bool {
        return coordinates.count > 1
    }
    
    public func bbox() -> BoundingBox? {
        return DefaultBoundingBox.create(coordinates)
    }
    
    public func transform(_ transform: (any Coordinate) -> any Coordinate) -> DefaultLineString {
        var newCoords: [any Coordinate] = []
        for coord in coordinates {
            newCoords.append(transform(coord))
        }
        return DefaultLineString(coordinates: newCoords)
    }
    
    public func length() -> Double {
        var length: Double = 0
        var prevCoordinate: (any Coordinate)? = nil
        for coordinate in coordinates {
            if let prevCoordinate = prevCoordinate {
                length += prevCoordinate.distance2D(to: coordinate)
            }
            prevCoordinate = coordinate
        }
        return length
    }
    
    public func coordinate(index: Int, skip: Int) -> (any Coordinate)? {
        let newIndex = index + skip
        if newIndex < 0 || newIndex >= coordinates.count {
            return nil
        }
        return coordinates[newIndex]
    }
    
    public func removeDuplicatePoints() -> DefaultLineString {
        var newCoordinates: [any Coordinate] = []
        var prevCoordinate: (any Coordinate)?
        for coordinate in coordinates {
            if let prevCoordinate = prevCoordinate, coordinate.isEqual(to: prevCoordinate) {
                continue
            }
            newCoordinates.append(coordinate)
            prevCoordinate = coordinate
        }
        return DefaultLineString(coordinates: newCoordinates)
    }
    
}
