//
//  File.swift
//  swift-s101
//

import Foundation

public struct DefaultCoordinate2D: Coordinate {
    
    public let x: Double
    public let y: Double

    public func isEqual(to other: Coordinate) -> Bool {
        if let other = other as? DefaultCoordinate2D {
            return x == other.x && y == other.y
        }
        return false
    }
    
    public func transform(newX: Double, newY: Double) -> DefaultCoordinate2D {
        return DefaultCoordinate2D(x: newX, y: newY)
    }
    
    public func distance2D(to other: Coordinate) -> Double {
        return sqrt(pow(x - other.x, 2.0) + pow(y - other.y, 2.0))
    }

}
