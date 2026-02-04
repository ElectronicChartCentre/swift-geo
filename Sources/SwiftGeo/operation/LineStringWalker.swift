//
//  File.swift
//  swift-geo
//

import Foundation

public struct LineStringWalker {
    
    private let segments: [Segment]
    private let length: Double
    
    public init(lineString: LineString) {
        self.init(coordinates: lineString.coordinates)
    }
    
    public init(linearRing: LinearRing) {
        self.init(coordinates: linearRing.coordinates)
    }
    
    private init(coordinates: [Coordinate]) {
        var segments: [Segment] = []
        var length: Double = 0
        
        var prevCoordinate: Coordinate? = nil
        for coordinate in coordinates {
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
    
    public func coordinate2DAtFactor(factor: Double, creator: GeometryCreator) -> Coordinate? {
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
                
                let steepFactor = segment.steepFactor()
                let x = segment.c0.x + remainingDistanceFactor * segment.dx()
                let y = segment.c0.y + remainingDistanceFactor * segment.dy()
                return creator.createCoordinate2D(x: x, y: y)
            }
            
            distanceTraveled += segment.length
        }

        return nil
    }
    
    private struct Segment {
        
        let c0: Coordinate
        let c1: Coordinate
        let length: Double
        
        init(c0: Coordinate, c1: Coordinate) {
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
