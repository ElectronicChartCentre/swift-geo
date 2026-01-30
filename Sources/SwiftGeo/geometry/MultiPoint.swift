//
//  File.swift
//  swift-geo
//

import Foundation

public protocol MultiPoint: MultiGeometry {
    
    func numCoordinates() -> Int
    
    func coordinate(_ idx: Int) -> Coordinate
    
}
