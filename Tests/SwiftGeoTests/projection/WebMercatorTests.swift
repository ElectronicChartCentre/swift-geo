//
//  Test.swift
//  swift-geo
//

import Testing

@testable import SwiftGeo

struct WebMercatorTests {

    @Test func testWebMercator() async throws {
        let p = WebMercator(x: 69725, y: 38627, z: 17, pixelRatio: 1)
        let c = DefaultGeometryCreator()
        let t = 0.00001
        
        let minLon = 11.505432119658801
        let minLat = 59.21531551525962
        let maxLon = 11.508167972853501
        let maxLat = 59.21671573243104
        
        let lowerLeftLL = c.createCoordinate2D(x: minLon, y: minLat)
        let lowerLeftXY = c.createCoordinate2D(x: 0, y: 0)
        let calculatedLowerLeftXY = p.forward(coordinate: lowerLeftLL)
        let calculatedLowerLeftLL = p.inverse(coordinate: lowerLeftXY)
        #expect(lowerLeftXY.distance2D(to: calculatedLowerLeftXY) < t)
        #expect(lowerLeftLL.distance2D(to: calculatedLowerLeftLL) < t)

        let upperRightLL = c.createCoordinate2D(x: maxLon, y: maxLat)
        let upperRightXY = c.createCoordinate2D(x: 255, y: 255)
        let calculatedUpperRightXY = p.forward(coordinate: upperRightLL)
        let calculatedUpperRightLL = p.inverse(coordinate: upperRightXY)
        #expect(upperRightXY.distance2D(to: calculatedUpperRightXY) < t)
        #expect(upperRightLL.distance2D(to: calculatedUpperRightLL) < t)
        
        let upperLeftLL = c.createCoordinate2D(x: minLon, y: maxLat)
        let upperLeftXY = c.createCoordinate2D(x: 0, y: 255)
        let calculatedUpperLeftXY = p.forward(coordinate: upperLeftLL)
        let calculatedUpperLeftLL = p.inverse(coordinate: upperLeftXY)
        #expect(upperLeftXY.distance2D(to: calculatedUpperLeftXY) < t)
        #expect(upperLeftLL.distance2D(to: calculatedUpperLeftLL) < t)

        let lowerRightLL = c.createCoordinate2D(x: maxLon, y: minLat)
        let lowerRightXY = c.createCoordinate2D(x: 255, y: 0)
        let calculatedLowerRightXY = p.forward(coordinate: lowerRightLL)
        let calculatedLowerRightLL = p.inverse(coordinate: lowerRightXY)
        #expect(lowerRightXY.distance2D(to: calculatedLowerRightXY) < t)
        #expect(lowerRightLL.distance2D(to: calculatedLowerRightLL) < t)
    }

}
