//
//  File.swift
//  swift-geo
//

import Foundation

public struct DefaultMultiPoint: MultiPoint {
    
    private let _coordinates: [any Coordinate]
    
    public init(coordinates: [any Coordinate]) {
        _coordinates = coordinates
    }
    
    public func geometries() -> [Geometry] {
        var geometries: [Geometry] = []
        for coordinate in _coordinates {
            geometries.append(DefaultPoint(coordinate: coordinate))
        }
        return geometries
    }
    
    public func coordinates() -> [any Coordinate] {
        return _coordinates
    }
    
    public func isEmpty() -> Bool {
        return _coordinates.isEmpty
    }
    
    public func isValid() -> Bool {
        return true
    }
    
    public func bbox() -> BoundingBox? {
        return DefaultBoundingBox.create(_coordinates)
    }
    
    public func transform(_ transform: (any Coordinate) -> any Coordinate) -> DefaultMultiPoint {
        var newCoordinates: [any Coordinate] = []
        for coordinate in _coordinates {
            newCoordinates.append(transform(coordinate))
        }
        return DefaultMultiPoint(coordinates: newCoordinates)
    }
    
}
