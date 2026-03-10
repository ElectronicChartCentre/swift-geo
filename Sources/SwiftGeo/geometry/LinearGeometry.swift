//
//  File.swift
//  swift-geo
//

import Foundation

public protocol LinearGeometry: Geometry {
    
    var coordinates: any CoordinateSequence { get }
    
    func length() -> Double
    
    func coordinate(index: Int, skip: Int) -> (any Coordinate)?
    
    func removeDuplicatePoints() -> Self
    
}
