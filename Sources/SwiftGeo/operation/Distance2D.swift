//
//  File.swift
//  swift-geo
//

import Foundation

public struct Distance2D {
    
    public func coordinateToLine(c: any Coordinate, line: LinearGeometry) -> Double {
        var distance: Double = .greatestFiniteMagnitude
        for (i, coordinate) in line.coordinates.enumerated() {
            guard let nextCoordinate = line.coordinate(index: i, skip: 1) else {
                continue
            }
            
            distance = min(distance, coordinateToLineSegment(c: c, a: coordinate, b: nextCoordinate))
        }
        return distance
    }
    
    public func coordinateToLineSegment(c: any Coordinate, a: any Coordinate, b: any Coordinate) -> Double {

        if c.x == a.x && c.y == a.y {
            return 0
        }
        
        if c.x == b.x && c.y == b.y {
            return 0
        }
        
        if a.x == b.x && a.y == b.y {
            return c.distance2D(to: a)
        }
        
        // https://www.inf.pucrs.br/~pinho/CG/faq.html
        // Subject 1.02: How do I find the distance from a point to a line?
        
        let ac = Vector2D(from: a, to: c)
        let ab = Vector2D(from: a, to: b)
        let l2 = pow(ab.length(), 2)
        
        let r = ac.dot(ab) / l2
        
        if r < 0 {
            return c.distance2D(to: a)
        }
        if r > 0 {
            return c.distance2D(to: b)
        }

        return ((a.y - c.y) * (b.x - a.x) - (a.x - c.x) * (b.y - a.y)) / l2
    }
    
}
