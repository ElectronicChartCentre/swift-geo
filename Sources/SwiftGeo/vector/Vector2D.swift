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
    
    public init (coordinate: any Coordinate) {
        self.x = coordinate.x
        self.y = coordinate.y
    }
    
    public init (from: any Coordinate, to: any Coordinate) {
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
    
    public func add(_ other: any Coordinate) -> Vector2D {
        return Vector2D(x: x + other.x, y: y + other.y)
    }
    
    public func coordinate(creator: GeometryCreator) -> any Coordinate {
        return creator.createCoordinate2D(x: x, y: y)
    }
    
    public func unit() -> Vector2D {
        let length = length()
        if length == 0 {
            print("ERROR: /0 problem in Vector2D.unit()")
        }
        return Vector2D(x: x / length, y: y / length)
    }
    
    public static func unit(from: any Coordinate, to: any Coordinate) -> Vector2D {
        let length = from.distance2D(to: to)
        if length == 0 {
            print("ERROR: /0 problem in Vector2D.unit()")
        }
        let x = to.x - from.x
        let y = to.y - from.y
        return Vector2D(x: x / length, y: y / length)
    }
    
    public func scale(_ factor: Double) -> Vector2D {
        return Vector2D(x: x * factor, y: y * factor)
    }

}
