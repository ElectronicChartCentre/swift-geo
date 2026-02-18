//
//  Test.swift
//  swift-geo
//

import Testing

@testable import SwiftGeo

struct OrientationTests {

    @Test func testDirection() async throws {
        let c = DefaultGeometryCreator()
        
        // easy CW
        var coords: [any Coordinate] = []
        coords.append(c.createCoordinate2D(x: 10, y: 10))
        coords.append(c.createCoordinate2D(x: 15, y: 20))
        coords.append(c.createCoordinate2D(x: 20, y: 10))
        coords.append(c.createCoordinate2D(x: 10, y: 10))
        let ring = c.createLinearRing(coords: coords)
        #expect(Orientation.direction(ring: ring) == .CW)
        #expect(Orientation.direction(ring: c.createLinearRing(coords: coords.reversed())) == .CCW)

        // easy CCW
        var coords2: [any Coordinate] = []
        coords2.append(c.createCoordinate2D(x: 10, y: 10))
        coords2.append(c.createCoordinate2D(x: 20, y: 10))
        coords2.append(c.createCoordinate2D(x: 15, y: 20))
        coords2.append(c.createCoordinate2D(x: 10, y: 10))
        let ring2 = c.createLinearRing(coords: coords2)
        #expect(Orientation.direction(ring: ring2) == .CCW)
        #expect(Orientation.direction(ring: c.createLinearRing(coords: coords2.reversed())) == .CW)

        // south of equator
        var coords3: [any Coordinate] = []
        coords3.append(c.createCoordinate2D(x: 61.8727775, y: -32.543733))
        coords3.append(c.createCoordinate2D(x: 61.8388515, y: -32.543733))
        coords3.append(c.createCoordinate2D(x: 61.8388515, y: -32.532533))
        coords3.append(c.createCoordinate2D(x: 61.8727775, y: -32.532533))
        coords3.append(c.createCoordinate2D(x: 61.8727775, y: -32.543733))
        let ring3 = c.createLinearRing(coords: coords3)
        #expect(Orientation.direction(ring: ring3) == .CW)
        #expect(Orientation.direction(ring: c.createLinearRing(coords: coords3.reversed())) == .CCW)

        // small
        var coords4: [any Coordinate] = []
        coords4.append(c.createCoordinate2D(x: 12.1370553, y: 54.1685131))
        coords4.append(c.createCoordinate2D(x: 12.1370549, y: 54.1685085))
        coords4.append(c.createCoordinate2D(x: 12.1370518, y: 54.1685086))
        coords4.append(c.createCoordinate2D(x: 12.1370518, y: 54.1685086))
        coords4.append(c.createCoordinate2D(x: 12.1370553, y: 54.1685131))
        let ring4 = c.createLinearRing(coords: coords4)
        #expect(Orientation.direction(ring: ring4) == .CW)
        #expect(Orientation.direction(ring: c.createLinearRing(coords: coords4.reversed())) == .CCW)

        // very small and with equal coordinates
        var coords5: [any Coordinate] = []
        coords5.append(c.createCoordinate2D(x: 12.1132686, y: 54.1643966))
        coords5.append(c.createCoordinate2D(x: 12.1132684, y: 54.1643966))
        coords5.append(c.createCoordinate2D(x: 12.1132684, y: 54.1643969))
        coords5.append(c.createCoordinate2D(x: 12.1132684, y: 54.1643969))
        coords5.append(c.createCoordinate2D(x: 12.1132686, y: 54.1643966))
        let ring5 = c.createLinearRing(coords: coords5)
        #expect(Orientation.direction(ring: ring5) == .CW)
        #expect(Orientation.direction(ring: c.createLinearRing(coords: coords5.reversed())) == .CCW)
    }

}
