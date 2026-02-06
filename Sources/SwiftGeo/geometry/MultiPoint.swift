//
//  File.swift
//  swift-geo
//

import Foundation

public protocol MultiPoint: MultiGeometry {
    
    func coordinates() -> [any Coordinate]
    
}
