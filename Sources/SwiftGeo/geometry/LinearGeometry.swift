//
//  File.swift
//  swift-geo
//

import Foundation

public protocol LinearGeometry: Geometry {
    
    var coordinates: [Coordinate] { get }
    
    func length() -> Double
    
    func coordinate(at index: Int) -> Coordinate?
    
}
