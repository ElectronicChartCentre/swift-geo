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
        // Accepts open or closed rings (first may or may not equal last)
        guard ring.coordinates.count >= 3 else { return .Unknown }

        let n: Int
        if ring.coordinates.count >= 2, ring.coordinates.first!.x == ring.coordinates.last!.x, ring.coordinates.first!.y == ring.coordinates.last!.y {
            n = ring.coordinates.count - 1
        } else {
            n = ring.coordinates.count
        }
        guard n >= 3 else { return .Unknown }

        // Shoelace: signedArea = 0.5 * Σ(x_i*y_{i+1} - x_{i+1}*y_i)
        // For y-up coordinates: signedArea > 0 => counter-clockwise, < 0 => clockwise
        var area2 = 0.0
        for i in 0..<n {
            let j = (i + 1) % n
            area2 += ring.coordinates[i].x * ring.coordinates[j].y - ring.coordinates[j].x * ring.coordinates[i].y
        }

        let epsilon: Double = 1e-10
        if area2 > epsilon { return .CCW }
        if area2 < -epsilon { return .CW }
        return .Unknown
    }
    
    public static func ensureDirection(ring: LinearRing, direction: OrientationDirection, creator: GeometryCreator) -> LinearRing {
        
        if Orientation.direction(ring: ring) == direction {
            return ring
        }
        
        return creator.createLinearRing(coords: ring.coordinates.reversed())
    }
    
}
