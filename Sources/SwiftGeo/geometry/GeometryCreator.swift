//
//  File.swift
//  swift-s101
//

import Foundation

public protocol GeometryCreator: Sendable {
    
    func createCoordinate2D(x: Double, y: Double) -> (any Coordinate)
    
    func createCoordinate3D(x: Double, y: Double, z: Double) -> (any Coordinate)
    
    func createEmptyGeometry() -> Geometry
    
    func createPoint(coord: any Coordinate) -> Point
    
    func createMultiPoint(coords: [any Coordinate]) -> Geometry
    
    func createMultiPoint(coords: any CoordinateSequence) -> Geometry
    
    func createLineString(coords: [any Coordinate]) -> LineString
    
    func createLineString(coords: any CoordinateSequence) -> LineString
    
    func createLinearRing(coords: [any Coordinate]) -> LinearRing
    
    func createLinearRing(coords: any CoordinateSequence) -> LinearRing
    
    func createPolygon(shell: LinearRing, holes: [LinearRing]) -> Polygon
    
    func createGeometry(geometries: [Geometry]) -> Geometry
    
}
