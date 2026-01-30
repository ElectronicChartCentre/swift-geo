//
//  File.swift
//  swift-geo
//

import Foundation

public struct DefaultMultiPoint: MultiPoint {
    
    public let coordinates: [Coordinate]
    
    public func numGeometries() -> Int {
        return coordinates.count
    }
    
    public func geometry(_ idx: Int) -> Geometry {
        return DefaultPoint(coordinate: coordinates[idx])
    }
    
    public func numCoordinates() -> Int {
        return coordinates.count
    }
    
    public func coordinate(_ idx: Int) -> Coordinate {
        return coordinates[idx]
    }
    
    public func isEmpty() -> Bool {
        return coordinates.isEmpty
    }
    
    public func isValid() -> Bool {
        return true
    }
    
    public func bbox() -> BoundingBox? {
        return DefaultBoundingBox.create(coordinates)
    }
    
    public func transform(_ transform: (any Coordinate) -> any Coordinate) -> DefaultMultiPoint {
        var newCoordinates: [Coordinate] = []
        for coordinate in newCoordinates {
            newCoordinates.append(transform(coordinate))
        }
        return DefaultMultiPoint(coordinates: coordinates)
    }
    
}
