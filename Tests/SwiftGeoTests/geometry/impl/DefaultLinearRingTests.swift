//
//  Test.swift
//  swift-geo
//

import Testing

@testable import SwiftGeo

struct DefaultLinearRingTests {

    @Test func testCoordinateAtIndexWithSkip() async throws {
        // not a real ring, but easy to understand numbers..
        let c0 = DefaultCoordinate2D(x: 0, y: 0)
        let c1 = DefaultCoordinate2D(x: 1, y: 1)
        let c2 = DefaultCoordinate2D(x: 2, y: 2)
        let c3 = DefaultCoordinate2D(x: 3, y: 3)
        let c4 = DefaultCoordinate2D(x: 4, y: 4)

        let ring = DefaultLinearRing(coordinates: [c0, c1, c2, c3, c4, c0])
        
        #expect(c0.isEqual(to: ring.coordinate(index: 0, skip: 0)))
        #expect(c1.isEqual(to: ring.coordinate(index: 1, skip: 0)))
        #expect(c2.isEqual(to: ring.coordinate(index: 2, skip: 0)))
        #expect(c3.isEqual(to: ring.coordinate(index: 3, skip: 0)))
        #expect(c4.isEqual(to: ring.coordinate(index: 4, skip: 0)))
        #expect(c0.isEqual(to: ring.coordinate(index: 5, skip: 0)))

        #expect(c4.isEqual(to: ring.coordinate(index: 0, skip: -1)))
        #expect(c0.isEqual(to: ring.coordinate(index: 1, skip: -1)))
        #expect(c1.isEqual(to: ring.coordinate(index: 2, skip: -1)))
        #expect(c2.isEqual(to: ring.coordinate(index: 3, skip: -1)))
        #expect(c3.isEqual(to: ring.coordinate(index: 4, skip: -1)))
        
        #expect(c3.isEqual(to: ring.coordinate(index: 0, skip: -2)))
        #expect(c4.isEqual(to: ring.coordinate(index: 1, skip: -2)))
        #expect(c0.isEqual(to: ring.coordinate(index: 2, skip: -2)))
        #expect(c1.isEqual(to: ring.coordinate(index: 3, skip: -2)))
        #expect(c2.isEqual(to: ring.coordinate(index: 4, skip: -2)))

        #expect(c1.isEqual(to: ring.coordinate(index: 0, skip: 1)))
        #expect(c2.isEqual(to: ring.coordinate(index: 1, skip: 1)))
        #expect(c3.isEqual(to: ring.coordinate(index: 2, skip: 1)))
        #expect(c4.isEqual(to: ring.coordinate(index: 3, skip: 1)))
        #expect(c0.isEqual(to: ring.coordinate(index: 4, skip: 1)))
        
        #expect(c2.isEqual(to: ring.coordinate(index: 0, skip: 2)))
        #expect(c3.isEqual(to: ring.coordinate(index: 1, skip: 2)))
        #expect(c4.isEqual(to: ring.coordinate(index: 2, skip: 2)))
        #expect(c0.isEqual(to: ring.coordinate(index: 3, skip: 2)))
        #expect(c1.isEqual(to: ring.coordinate(index: 4, skip: 2)))
        
    }

}
