//
//  File.swift
//  swift-s100-portrayal
//

import Foundation

public struct IdentityProjection: Projection {
    
    public init() {
        
    }
    
    public func forward(coordinate: any Coordinate) -> any Coordinate {
        return coordinate
    }
    
    public func inverse(coordinate: any Coordinate) -> any Coordinate {
        return coordinate
    }
    
    public func forward(geometry: Geometry) -> Geometry {
        return geometry
    }
    
    public func inverse(geometry: Geometry) -> Geometry {
        return geometry
    }
    
}
