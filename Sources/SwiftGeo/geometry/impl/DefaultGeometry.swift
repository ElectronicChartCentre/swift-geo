//
//  File.swift
//  swift-s101
//

import Foundation

public struct DefaultGeometry: Geometry {
    
    public let coords: [any Coordinate]
    
    public func isEmpty() -> Bool {
        return coords.isEmpty
    }
    
    public func isValid() -> Bool {
        return true
    }
    
    public func bbox() -> BoundingBox? {
        return DefaultBoundingBox.create(coords)
    }
    
    public func transform(_ transform: (any Coordinate) -> (any Coordinate)) -> DefaultGeometry {
        var newCoords: [any Coordinate] = []
        for coord in coords {
            newCoords.append(transform(coord))
        }
        return DefaultGeometry(coords: newCoords)
    }
    
}
