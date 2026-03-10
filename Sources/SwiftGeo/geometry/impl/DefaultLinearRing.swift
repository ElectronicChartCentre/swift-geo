//
//  File.swift
//  swift-s101
//

import Foundation

public struct DefaultLinearRing: LinearRing {
    
    public let coordinates: any CoordinateSequence
    
    public init(coordinates: [any Coordinate]) {
        self.coordinates = ArrayCoordinateSequence(coordinates)
    }
    
    public init(coordinates: any CoordinateSequence) {
        self.coordinates = coordinates
    }
    
    public func isEmpty() -> Bool {
        return coordinates.isEmpty
    }
    
    public func isValid() -> Bool {
        if coordinates.count < 3 {
            return false
        }
        return coordinates[0].isEqual(to: coordinates[coordinates.count - 1])
    }
    
    public func bbox() -> BoundingBox? {
        return DefaultBoundingBox.create(coordinates)
    }
    
    public func transform(_ transform: (any Coordinate) -> (any Coordinate)) -> DefaultLinearRing {
        let cs = coordinates.transform(transform)
        return DefaultLinearRing(coordinates: cs)
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
        
        // treat duplicate coordinate at start/stop as just one coordinate
        
        // first at beginning of ring
        if index >= 0, (index + skip) < 0 {
            let newIndex = index + skip - 1 + coordinates.count
            return coordinates[newIndex]
        }
        
        // then at end of ring
        if index < coordinates.count, (index + skip) >= coordinates.count {
            let newIndex = index + skip + 1 - coordinates.count
            return coordinates[newIndex]
        }
        
        // normal
        return coordinates[index + skip]
    }

    public func removeDuplicatePoints() -> DefaultLinearRing {
        var newCoordinates: [any Coordinate] = []
        var prevCoordinate: (any Coordinate)?
        for coordinate in coordinates {
            if let prevCoordinate = prevCoordinate, coordinate.isEqual(to: prevCoordinate) {
                continue
            }
            newCoordinates.append(coordinate)
            prevCoordinate = coordinate
        }
        return DefaultLinearRing(coordinates: newCoordinates)
    }

}
