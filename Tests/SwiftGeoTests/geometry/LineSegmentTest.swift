//
//  Test.swift
//  swift-geo
//

import Testing

@testable import SwiftGeo

struct LineSegmentTest {

    @Test func testClosestDiagonal() async throws {
        let creator = DefaultGeometryCreator()
        
        let c0 = creator.createCoordinate2D(x: 0, y: 0)
        let c1 = creator.createCoordinate2D(x: 1, y: 1)
        
        let segment = LineSegment(c0: c0, c1: c1)
        
        #expect(segment.closestCoordinate(other: c0).isEqual(to: c0))
        #expect(segment.closestCoordinate(other: c1).isEqual(to: c1))
        
        let c3 = creator.createCoordinate2D(x: 0.2, y: 0.2)
        let c4 = creator.createCoordinate2D(x: 0.5, y: 0.5)
        let c5 = creator.createCoordinate2D(x: 0.8, y: 0.8)

        #expect(segment.closestCoordinate(other: c3).distance2D(to: c3) < 0.0000001)
        #expect(segment.closestCoordinate(other: c4).distance2D(to: c4) < 0.0000001)
        #expect(segment.closestCoordinate(other: c5).distance2D(to: c5) < 0.0000001)
    }
    
    @Test func testClosestHorizontal() async throws {
        let creator = DefaultGeometryCreator()
        
        let c0 = creator.createCoordinate2D(x: 0, y: 0)
        let c1 = creator.createCoordinate2D(x: 1, y: 0)
        
        let segment = LineSegment(c0: c0, c1: c1)
        
        #expect(segment.closestCoordinate(other: c0).isEqual(to: c0))
        #expect(segment.closestCoordinate(other: c1).isEqual(to: c1))
        
        let c3 = creator.createCoordinate2D(x: 0.2, y: 0)
        let c4 = creator.createCoordinate2D(x: 0.5, y: 0)
        let c5 = creator.createCoordinate2D(x: 0.8, y: 0)

        #expect(segment.closestCoordinate(other: c3).distance2D(to: c3) < 0.0000001)
        #expect(segment.closestCoordinate(other: c4).distance2D(to: c4) < 0.0000001)
        #expect(segment.closestCoordinate(other: c5).distance2D(to: c5) < 0.0000001)
        
        let c5over = creator.createCoordinate2D(x: 0.8, y: 0.1)
        let c5under = creator.createCoordinate2D(x: 0.8, y: -0.1)

        #expect(segment.closestCoordinate(other: c5over).distance2D(to: c5) < 0.0000001)
        #expect(segment.closestCoordinate(other: c5under).distance2D(to: c5) < 0.0000001)
    }
    
    @Test func testClosestVertical() async throws {
        let creator = DefaultGeometryCreator()
        
        let c0 = creator.createCoordinate2D(x: 0, y: 0)
        let c1 = creator.createCoordinate2D(x: 0, y: 1)
        
        let segment = LineSegment(c0: c0, c1: c1)
        
        #expect(segment.closestCoordinate(other: c0).isEqual(to: c0))
        #expect(segment.closestCoordinate(other: c1).isEqual(to: c1))
        
        let c3 = creator.createCoordinate2D(x: 0, y: 0.2)
        let c4 = creator.createCoordinate2D(x: 0, y: 0.5)
        let c5 = creator.createCoordinate2D(x: 0, y: 0.8)

        #expect(segment.closestCoordinate(other: c3).distance2D(to: c3) < 0.0000001)
        #expect(segment.closestCoordinate(other: c4).distance2D(to: c4) < 0.0000001)
        #expect(segment.closestCoordinate(other: c5).distance2D(to: c5) < 0.0000001)
        
        let c5left = creator.createCoordinate2D(x: -0.1, y: 0.8)
        let c5right = creator.createCoordinate2D(x: 0.1, y: 0.8)

        #expect(segment.closestCoordinate(other: c5left).distance2D(to: c5) < 0.0000001)
        #expect(segment.closestCoordinate(other: c5right).distance2D(to: c5) < 0.0000001)
    }

}
