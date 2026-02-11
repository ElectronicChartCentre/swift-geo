//
//  Test.swift
//  swift-geo
//

import Testing

@testable import SwiftGeo

struct GeoJSONDecoderTests {
    
    @Test func testParsePoint() async throws {
        let creator = DefaultGeometryCreator()
        let pointText = "{\"type\":\"Point\",\"coordinates\":[5.599491,59.035779]}"
        
        guard let geometry = GeoJSONDecoder.parseGeometry(data: pointText.data(using: .utf8)!, creator: creator) else {
            Issue.record("Could not parse Point")
            return
        }
        
        guard let _ = geometry as? Point else {
            Issue.record("Parsed geometry is not a Point")
            return
        }
    }

    @Test func testParseLineString() async throws {
        let creator = DefaultGeometryCreator()
        let lineStringText = "{\"type\":\"LineString\",\"coordinates\":[[5.599491,59.035779],[5.471368,59.048275],[5.453207,59.047037],[5.42949,59.052006],[5.417523,59.05733]]}"
        
        guard let geometry = GeoJSONDecoder.parseGeometry(data: lineStringText.data(using: .utf8)!, creator: creator) else {
            Issue.record("Could not parse LineString")
            return
        }
        
        guard let lineString = geometry as? LineString else {
            Issue.record("Parsed geometry is not a LineString")
            return
        }
        
        #expect(lineString.coordinates.count == 5)
    }
    
    @Test func testParseFeature() async throws {
        let creator = DefaultGeometryCreator()
        let text = "{\"type\":\"Feature\",\"properties\":{\"a\":\"b\"},\"geometry\":{\"type\":\"LineString\",\"coordinates\":[[5.599491,59.035779],[5.471368,59.048275],[5.453207,59.047037],[5.42949,59.052006],[5.417523,59.05733]]}}"
        
        guard let feature = GeoJSONDecoder.parseFeature(data: text.data(using: .utf8)!, creator: creator) else {
            Issue.record("Could not parse Feature")
            return
        }
        
        guard let lineString = feature.geometry as? LineString else {
            Issue.record("Parsed geometry is not a LineString")
            return
        }
        
        #expect(feature.properties["a"] as? String == "b")
        #expect(lineString.coordinates.count == 5)
    }

}
