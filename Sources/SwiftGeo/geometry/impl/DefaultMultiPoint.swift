//
//  File.swift
//  swift-geo
//

import Foundation

public struct DefaultMultiPoint: MultiPoint {
    
    public let coordinates: any CoordinateSequence
    
    public init(coordinates: [any Coordinate]) {
        self.coordinates = ArrayCoordinateSequence(coordinates)
    }
    
    public init(coordinates: any CoordinateSequence) {
        self.coordinates = coordinates
    }
    
    public func geometries() -> [Geometry] {
        var geometries: [Geometry] = []
        for coordinate in coordinates {
            geometries.append(DefaultPoint(coordinate: coordinate))
        }
        return geometries
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
        let newCoordinates = coordinates.transform(transform)
        return DefaultMultiPoint(coordinates: newCoordinates)
    }
    
}
