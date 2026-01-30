//
//  Test.swift
//  swift-geo
//

import Testing
@testable import SwiftGeo

struct LLXYProjectionTests {

    @Test func testLLXY() async throws {
        let bbox = DefaultBoundingBox(minX: 10, maxX: 20, minY: 30, maxY: 50)
        let proj = LLXYProjection(bbox: bbox, widthPoint: 100, heightPoint: 200, pixelsPrPoint: 1)
        
        let llw = DefaultCoordinate2D(x: 10, y: 30)
        let lls = DefaultCoordinate2D(x: 0, y: 0)
        let llsCalculated = proj.forward(coordinate: llw)
        let llwCalculated = proj.inverse(coordinate: lls)
        
        #expect(llsCalculated.x == lls.x)
        #expect(llsCalculated.y == lls.y)
        #expect(llwCalculated.x == llw.x)
        #expect(llwCalculated.y == llw.y)
        
        let urw = DefaultCoordinate2D(x: 20, y: 50)
        let urs = DefaultCoordinate2D(x: 100, y: 200)
        let ursCalculated = proj.forward(coordinate: urw)
        let urwCalculated = proj.inverse(coordinate: urs)
        
        #expect(ursCalculated.x == urs.x)
        #expect(ursCalculated.y == urs.y)
        #expect(urwCalculated.x == urw.x)
        #expect(urwCalculated.y == urw.y)
    }

}
