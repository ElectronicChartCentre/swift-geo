//
//  File.swift
//  swift-s101
//

import Foundation

public protocol GeometryCreator {
    
    func createCoordinate2D(x: Double, y: Double) -> (any Coordinate)
    
    func createCoordinate3D(x: Double, y: Double, z: Double) -> (any Coordinate)
    
    func createEmptyGeometry() -> Geometry
    
    func createPoint(coord: any Coordinate) -> Point
    
    func createMultiPoint(coords: [any Coordinate]) -> Geometry
    
    func createLineString(coords: [any Coordinate]) -> LineString
    
    func createLinearRing(coords: [any Coordinate]) -> LinearRing
    
    func createPolygon(shell: LinearRing, holes: [LinearRing]) -> Polygon
    
    func createGeometry(geometries: [Geometry]) -> Geometry
    
}
