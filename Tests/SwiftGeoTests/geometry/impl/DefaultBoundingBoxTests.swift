//
//  Test.swift
//  swift-geo
//

import Testing
@testable import SwiftGeo

struct DefaultBoundingBoxTests {

    @Test func testGrow() async throws {
        let bbox = DefaultBoundingBox(minX: 10, maxX: 30, minY: 50, maxY: 100)
        let bbox2 = bbox.grow(factor: 1.5)
        
        #expect(bbox2.minX == 5)
        #expect(bbox2.maxX == 35)
        #expect(bbox2.minY == 37.5)
        #expect(bbox2.maxY == 112.5)
    }
    
    @Test func testContainsCoordinate() async throws {
        let bbox = DefaultBoundingBox(minX: 10, maxX: 30, minY: 50, maxY: 100)
        #expect(bbox.intersects(DefaultCoordinate2D(x: 20, y: 60)) == true)
        #expect(bbox.intersects(DefaultCoordinate2D(x: 0, y: 0)) == false)
    }

}
