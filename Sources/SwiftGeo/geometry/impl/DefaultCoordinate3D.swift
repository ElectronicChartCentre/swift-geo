//
//  File.swift
//  swift-s101
//

import Foundation

public struct DefaultCoordinate3D: Coordinate {
    
    public let x: Double
    public let y: Double
    public let z: Double
    
    public func isEqual(to other: Coordinate) -> Bool {
        if let other = other as? DefaultCoordinate3D {
            return x == other.x && y == other.y && z == other.z
        }
        return false
    }
    
    public func transform(newX: Double, newY: Double) -> DefaultCoordinate3D {
        return DefaultCoordinate3D(x: newX, y: newY, z: self.z)
    }
    
    public func distance2D(to other: Coordinate) -> Double {
        return sqrt(pow(x - other.x, 2.0) + pow(y - other.y, 2.0))
    }
    
}
