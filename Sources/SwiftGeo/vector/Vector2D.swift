//
//  File.swift
//  swift-geo
//

import Foundation

public struct Vector2D {
    
    public let x: Double
    public let y: Double
    
    public init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
    
    public init (coordinate: Coordinate) {
        self.x = coordinate.x
        self.y = coordinate.y
    }
    
    public init (from: Coordinate, to: Coordinate) {
        self.x = to.x - from.x
        self.y = to.y - from.y
    }
    
    public func direction() -> Double {
        return atan2(y, x)
    }
    
    public func length() -> Double {
        return hypot(x, y)
    }
    
    public func add(_ other: Vector2D) -> Vector2D {
        return Vector2D(x: x + other.x, y: y + other.y)
    }
    
    public func add(_ other: Coordinate) -> Vector2D {
        return Vector2D(x: x + other.x, y: y + other.y)
    }
    
    public func coordinate(creator: GeometryCreator) -> Coordinate {
        return creator.createCoordinate2D(x: x, y: y)
    }
    
    public func unit() -> Vector2D {
        let length = length()
        return Vector2D(x: x / length, y: y / length)
    }
    
    public func scale(_ factor: Double) -> Vector2D {
        return Vector2D(x: x * factor, y: y * factor)
    }

}
