//
//  File.swift
//  swift-geo
//

import Foundation

public protocol LineString: Geometry {
    
    var coordinates: [Coordinate] { get }
    
}
