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
    
    func intersects(_ other: any Coordinate) -> Bool
    
    func intersects(x: Double, y: Double) -> Bool

    func intersects(_ other: BoundingBox) -> Bool
    
    func grow(factor: Double) -> BoundingBox
    
    func grow(deltaX: Double, deltaY: Double) -> BoundingBox
    
    func transform(_ transform: (any Coordinate) -> (any Coordinate)) -> Self
    
}
