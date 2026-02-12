//
//  File.swift
//  swift-geo
//

import Foundation

public struct Feature {
    
    public let properties: [String: Any]
    public let geometry: Geometry
    
    public init(properties: [String : Any], geometry: Geometry) {
        self.properties = properties
        self.geometry = geometry
    }
    
}
