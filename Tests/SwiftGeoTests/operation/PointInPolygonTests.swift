//
//  PointInPolygonTests.swift
//  swift-geo
//

import Testing

@testable import SwiftGeo

struct PointInPolygonTests {

    @Test func testPointInsideSimplePolygon() async throws {
        let c = DefaultGeometryCreator()
        
        var coords: [any Coordinate] = []
        coords.append(c.createCoordinate2D(x: 0, y: 0))
        coords.append(c.createCoordinate2D(x: 10, y: 0))
        coords.append(c.createCoordinate2D(x: 10, y: 10))
        coords.append(c.createCoordinate2D(x: 0, y: 10))
        coords.append(c.createCoordinate2D(x: 0, y: 0))
        let ring = c.createLinearRing(coords: coords)
        let polygon = c.createPolygon(shell: ring, holes: [])
        
        #expect(PointInPolygon.isPointInPolygon(
            point: c.createCoordinate2D(x: 5, y: 5),
            polygon: polygon
        ) == true)
    }
    
    @Test func testPointOutsideSimplePolygon() async throws {
        let c = DefaultGeometryCreator()
        
        var coords: [any Coordinate] = []
        coords.append(c.createCoordinate2D(x: 0, y: 0))
        coords.append(c.createCoordinate2D(x: 10, y: 0))
        coords.append(c.createCoordinate2D(x: 10, y: 10))
        coords.append(c.createCoordinate2D(x: 0, y: 10))
        coords.append(c.createCoordinate2D(x: 0, y: 0))
        let ring = c.createLinearRing(coords: coords)
        let polygon = c.createPolygon(shell: ring, holes: [])
        
        #expect(PointInPolygon.isPointInPolygon(
            point: c.createCoordinate2D(x: -1, y: -1),
            polygon: polygon
        ) == false)
    }
    
    @Test func testPointOnEdge() async throws {
        let c = DefaultGeometryCreator()
        
        var coords: [any Coordinate] = []
        coords.append(c.createCoordinate2D(x: 0, y: 0))
        coords.append(c.createCoordinate2D(x: 10, y: 0))
        coords.append(c.createCoordinate2D(x: 10, y: 10))
        coords.append(c.createCoordinate2D(x: 0, y: 10))
        coords.append(c.createCoordinate2D(x: 0, y: 0))
        let ring = c.createLinearRing(coords: coords)
        let polygon = c.createPolygon(shell: ring, holes: [])
        
        #expect(PointInPolygon.isPointInPolygon(
            point: c.createCoordinate2D(x: 5, y: 0),
            polygon: polygon
        ) == true)
    }
    
    @Test func testPointInPolygonWithHole() async throws {
        let c = DefaultGeometryCreator()
        
        var shellCoords: [any Coordinate] = []
        shellCoords.append(c.createCoordinate2D(x: 0, y: 0))
        shellCoords.append(c.createCoordinate2D(x: 20, y: 0))
        shellCoords.append(c.createCoordinate2D(x: 20, y: 20))
        shellCoords.append(c.createCoordinate2D(x: 0, y: 20))
        shellCoords.append(c.createCoordinate2D(x: 0, y: 0))
        let shell = c.createLinearRing(coords: shellCoords)
        
        var holeCoords: [any Coordinate] = []
        holeCoords.append(c.createCoordinate2D(x: 5, y: 5))
        holeCoords.append(c.createCoordinate2D(x: 15, y: 5))
        holeCoords.append(c.createCoordinate2D(x: 15, y: 15))
        holeCoords.append(c.createCoordinate2D(x: 5, y: 15))
        holeCoords.append(c.createCoordinate2D(x: 5, y: 5))
        let hole = c.createLinearRing(coords: holeCoords)
        
        let polygon = c.createPolygon(shell: shell, holes: [hole])
        
        // Inside the hole
        #expect(PointInPolygon.isPointInPolygon(
            point: c.createCoordinate2D(x: 10, y: 10),
            polygon: polygon
        ) == false)
        
        // Outside the hole but inside the shell
        #expect(PointInPolygon.isPointInPolygon(
            point: c.createCoordinate2D(x: 2, y: 2),
            polygon: polygon
        ) == true)
    }
    
    @Test func testPointInTriangle() async throws {
        let c = DefaultGeometryCreator()
        
        var coords: [any Coordinate] = []
        coords.append(c.createCoordinate2D(x: 0, y: 0))
        coords.append(c.createCoordinate2D(x: 10, y: 0))
        coords.append(c.createCoordinate2D(x: 5, y: 10))
        coords.append(c.createCoordinate2D(x: 0, y: 0))
        let ring = c.createLinearRing(coords: coords)
        let polygon = c.createPolygon(shell: ring, holes: [])
        
        #expect(PointInPolygon.isPointInPolygon(
            point: c.createCoordinate2D(x: 5, y: 3),
            polygon: polygon
        ) == true)
        
        #expect(PointInPolygon.isPointInPolygon(
            point: c.createCoordinate2D(x: 5, y: 11),
            polygon: polygon
        ) == false)
    }
    
    @Test func testEmptyPolygon() async throws {
        let c = DefaultGeometryCreator()
        
        // Empty polygon (no shell)
        let emptyPolygon = c.createPolygon(shell: c.createLinearRing(coords: []), holes: [])
        
        #expect(PointInPolygon.isPointInPolygon(
            point: c.createCoordinate2D(x: 0, y: 0),
            polygon: emptyPolygon
        ) == false)
    }
    
}
