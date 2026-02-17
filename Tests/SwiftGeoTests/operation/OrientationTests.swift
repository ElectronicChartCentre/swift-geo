//
//  Test.swift
//  swift-geo
//

import Testing

@testable import SwiftGeo

struct OrientationTests {

    @Test func testIsCounterClockwise() async throws {
        let c = DefaultGeometryCreator()
        var coords: [any Coordinate] = []
        coords.append(c.createCoordinate2D(x: 10, y: 10))
        coords.append(c.createCoordinate2D(x: 15, y: 20))
        coords.append(c.createCoordinate2D(x: 20, y: 10))
        coords.append(c.createCoordinate2D(x: 10, y: 10))
        let ring = c.createLinearRing(coords: coords)
        #expect(Orientation.direction(ring: ring) == .CW)
        
        var coords2: [any Coordinate] = []
        coords2.append(c.createCoordinate2D(x: 10, y: 10))
        coords2.append(c.createCoordinate2D(x: 20, y: 10))
        coords2.append(c.createCoordinate2D(x: 15, y: 20))
        coords2.append(c.createCoordinate2D(x: 10, y: 10))
        let ring2 = c.createLinearRing(coords: coords2)
        #expect(Orientation.direction(ring: ring2) == .CCW)
    }

}
