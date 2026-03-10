//
//  File.swift
//  swift-s101
//

import Foundation

public struct DefaultPoint: Point {
    
    public let coordinate: any Coordinate
    
    public func isEmpty() -> Bool {
        return false
    }
    
    public func isValid() -> Bool {
        return true
    }
    
    public func bbox() -> BoundingBox? {
        return DefaultBoundingBox(minX: coordinate.x, maxX: coordinate.x, minY: coordinate.y, maxY: coordinate.y)
    }
    
    public func transform(_ transform: (any Coordinate) -> (any Coordinate)) -> DefaultPoint {
        return DefaultPoint(coordinate: transform(coordinate))
    }
    
}
