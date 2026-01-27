//
//  File.swift
//  swift-s100-portrayal
//

import Foundation

public struct IdentityProjection: Projection {
    
    public init() {
        
    }
    
    public func forward(coordinate: Coordinate) -> Coordinate {
        return coordinate
    }
    
    public func inverse(coordinate: Coordinate) -> Coordinate {
        return coordinate
    }
    
    public func forward(geometry: Geometry) -> Geometry {
        return geometry
    }
    
    public func inverse(geometry: Geometry) -> Geometry {
        return geometry
    }
    
}
