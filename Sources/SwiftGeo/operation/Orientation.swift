//
//  File.swift
//  swift-geo
//

import Foundation

public struct Orientation {
    
    public enum OrientationDirection {
        case CW
        case CCW
    }

    public static func direction(ring: LinearRing) -> OrientationDirection {
        var sumDeltaOrientation: Double = 0.0
        
        var prevDirection: Double?
        for i in 0..<ring.coordinates.count - 1 {
            let p1 = ring.coordinates[i]
            let p2 = ring.coordinates[i + 1]
            
            let x = p2.x - p1.x
            let y = p2.y - p1.y
            
            if x == 0, y == 0 {
                continue
            }
            
            let direction = atan2(y, x)
            
            if let prevDirection {
                let deltaDirection = direction - prevDirection
                sumDeltaOrientation += deltaDirection
            }
            
            prevDirection = direction
            
        }
        
        return sumDeltaOrientation < 0 ? .CCW : .CW
    }
    
    public static func ensureDirection(ring: LinearRing, direction: OrientationDirection, creator: GeometryCreator) -> LinearRing {
        
        if Orientation.direction(ring: ring) == direction {
            return ring
        }
        
        return creator.createLinearRing(coords: ring.coordinates.reversed())
    }
    
}
