//
//  PointInPolygon.swift
//  swift-geo
//

import Foundation

public struct PointInPolygon {
    
    public static func isPointInPolygon(coordinate: any Coordinate, polygon: any Polygon) -> Bool {
        guard !polygon.isEmpty() else {
            return false
        }
        
        if let bbox = polygon.bbox() {
            if !bbox.intersects(coordinate) {
                return false
            }
        }
        
        if !isPointInRing(coordinate: coordinate, ring: polygon.shell) {
            return false
        }
        
        for hole in polygon.holes {
            if isPointInRing(coordinate: coordinate, ring: hole) {
                return false
            }
        }
        
        return true
    }
    
    public static func isPointInPolygon(point: any Point, polygon: any Polygon) -> Bool {
        return isPointInPolygon(coordinate: point.coordinate, polygon: polygon)
    }
    
    private static func isPointInRing(coordinate: any Coordinate, ring: LinearRing) -> Bool {
        // Ray casting algorithm: cast a horizontal ray from the point to the right
        // and count how many edges it crosses. Odd count = inside, even = outside.
        // https://en.wikipedia.org/wiki/Point_in_polygon#Ray_casting_algorithm
        
        let coords = Array(ring.coordinates)
        guard coords.count >= 3 else {
            return false
        }
        
        var inside = false
        let x = coordinate.x
        let y = coordinate.y
        
        var j = coords.count - 2
        for i in 0..<coords.count - 1 {
            let xi = coords[i].x
            let yi = coords[i].y
            let xj = coords[j].x
            let yj = coords[j].y
            
            let intersect = ((yi > y) != (yj > y)) && (x < (xj - xi) * (y - yi) / (yj - yi) + xi)
            
            if intersect {
                inside = !inside
            }
            
            j = i
        }
        
        return inside
    }
    
}
