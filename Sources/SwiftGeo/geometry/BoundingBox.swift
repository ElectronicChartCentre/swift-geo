//
//  File.swift
//  swift-s101
//

import Foundation

public protocol BoundingBox {
    
    var minX: Double { get }
    
    var maxX: Double { get }

    var minY: Double { get }
    
    var maxY: Double { get }
    
    func intersects(_ other: Coordinate) -> Bool

    func intersects(_ other: BoundingBox) -> Bool
    
    func grow(factor: Double) -> BoundingBox
    
    func transform(_ transform: (Coordinate) -> Coordinate) -> Self
    
}
