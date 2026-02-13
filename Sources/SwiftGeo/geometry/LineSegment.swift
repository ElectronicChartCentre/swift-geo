//
//  File.swift
//  swift-geo
//

import Foundation

public struct LineSegment {
    
    public let c0: any Coordinate
    public let c1: any Coordinate
    
    public init(c0: any Coordinate, c1: any Coordinate) {
        self.c0 = c0
        self.c1 = c1
    }
    
    public func closestCoordinate(other: any Coordinate) -> any Coordinate {
        
        if other.x == c0.x && other.y == c0.y {
            return c0
        }
        if other.x == c1.x && other.y == c1.y {
            return c1
        }
        if c0.x == c1.x && c0.y == c1.y {
            return c0
        }
        
        // https://www.inf.pucrs.br/~pinho/CG/faq.html
        // Subject 1.02: How do I find the distance from a point to a line?
        
        let ac = Vector2D(from: c0, to: other)
        let ab = Vector2D(from: c0, to: c1)
        let r = ac.dot(ab) / pow(ab.length(), 2)
        
        if r > 0, r < 1 {
            // on line
            let x = c0.x + r * (c1.x - c0.x);
            let y = c0.y + r * (c1.y - c0.y);
            return other.transform(newX: x, newY: y)
        }

        let d0 = other.distance2D(to: c0)
        let d1 = other.distance2D(to: c1)
        
        if d0 < d1 {
            return c0
        }
        return c1

    }
    
}
