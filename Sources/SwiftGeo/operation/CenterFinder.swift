//
//  File.swift
//  swift-geo
//

import Foundation

public struct CenterFinder {
    
    private init() {
        
    }
    
    public static func centerCoordinate2D(geometry: Geometry, creator: GeometryCreator) -> Coordinate? {
        if geometry.isEmpty() {
            return nil
        }
        
        if let point = geometry as? Point {
            return point.coordinate
        }
        
        if let lineString = geometry as? LineString {
            let walker = LinearGeometryWalker(geometry: lineString)
            return walker.coordinate2DAtFactor(factor: 0.5, creator: creator)
        }
        
        var n: Double = 0
        var sumx: Double = 0
        var sumy: Double = 0
        
        // TODO: need to do this in a much smarter way
        if let polygon = geometry as? Polygon {
            var prevCoordinate: Coordinate? = nil
            for (index, coordinate) in polygon.shell.coordinates.enumerated() {
                if let prevCoordinate = prevCoordinate {
                    let length = coordinate.distance2D(to: prevCoordinate)
                    n += length
                    sumx += ((coordinate.x + prevCoordinate.x) / 2.0) * length
                    sumy += ((coordinate.y + prevCoordinate.y) / 2.0) * length
                }
                
                prevCoordinate = coordinate
            }
        } else {
            print("TODO: implement center coordinate for \(type(of: geometry))")
        }
        
        if n > 0 {
            let x = sumx / n
            let y = sumy / n
            return creator.createCoordinate2D(x: x, y: y)
        }
        
        return nil
    }
    
}
