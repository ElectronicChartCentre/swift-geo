//
//  File.swift
//  swift-geo
//

import Foundation

public struct LinearGeometryWalker {
    
    private let segments: [Segment]
    private let length: Double
    
    public init(geometry: LinearGeometry) {
        var segments: [Segment] = []
        var length: Double = 0
        
        var prevCoordinate: (any Coordinate)? = nil
        for coordinate in geometry.coordinates {
            if let prevCoordinate = prevCoordinate {
                let segment = Segment(c0: prevCoordinate, c1: coordinate)
                segments.append(segment)
                length += segment.length
            }
            prevCoordinate = coordinate
        }
        
        self.segments = segments
        self.length = length
    }
    
    public func coordinate2DAtFactor(factor: Double, creator: GeometryCreator) -> (any Coordinate)? {
        if factor < 0 {
            return nil
        }
        if factor > 1 {
            return nil
        }
        
        var distanceTraveled: Double = 0
        let distanceToTravel: Double = length * factor
        
        for segment in segments {
            let remainingDistance = distanceToTravel - distanceTraveled
            
            if remainingDistance < segment.length {
                // this is the segment.
                let remainingDistanceFactor = remainingDistance / segment.length
                
                // special case to prevent /0
                if segment.dx() == 0 {
                    let y = segment.c0.y + remainingDistanceFactor * segment.dy()
                    return creator.createCoordinate2D(x: segment.c0.x, y: y)
                }
                
                let x = segment.c0.x + remainingDistanceFactor * segment.dx()
                let y = segment.c0.y + remainingDistanceFactor * segment.dy()
                return creator.createCoordinate2D(x: x, y: y)
            }
            
            distanceTraveled += segment.length
        }

        return nil
    }
    
    private struct Segment {
        
        let c0: any Coordinate
        let c1: any Coordinate
        let length: Double
        
        init(c0: any Coordinate, c1: any Coordinate) {
            self.c0 = c0
            self.c1 = c1
            self.length = c0.distance2D(to: c1)
        }
        
        func dx() -> Double {
            return c1.x - c0.x
        }
        
        func dy() -> Double {
            return c1.y - c0.y
        }
        
        func steepFactor() -> Double {
            return dx() / dy()
        }
        
    }
    
}
