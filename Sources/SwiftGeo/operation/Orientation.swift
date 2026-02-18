//
//  File.swift
//  swift-geo
//

import Foundation

public struct Orientation {
    
    public enum OrientationDirection {
        case CW
        case CCW
        case Unknown
    }

    public static func direction(ring: LinearRing) -> OrientationDirection {
        let area = shoelaceArea(ring: ring)
        let epsilon: Double = 1e-20
        if area > epsilon { return .CW }
        if area < -epsilon { return .CCW }
        return .Unknown
    }
    
    private static func shoelaceArea(ring: LinearRing) -> Double {
        // http://en.wikipedia.org/wiki/Shoelace_formula
        
        if ring.coordinates.count < 3 {
            return 0
        }
        
        var sum: Double = 0
        
        let x0 = ring.coordinates[0].x
        for i in 1..<ring.coordinates.count - 1 {
            let x = ring.coordinates[i].x - x0
            let y1 = ring.coordinates[i + 1].y
            let y2 = ring.coordinates[i - 1].y
            sum += x * (y2 - y1)
        }
        
        return sum / 2.0
    }
    
    public static func ensureDirection(ring: LinearRing, direction: OrientationDirection, creator: GeometryCreator) -> LinearRing {
        
        if Orientation.direction(ring: ring) == direction {
            return ring
        }
        
        return creator.createLinearRing(coords: ring.coordinates.reversed())
    }
    
}
