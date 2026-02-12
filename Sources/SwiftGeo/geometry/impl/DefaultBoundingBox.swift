//
//  File.swift
//  swift-s101
//

import Foundation

public struct DefaultBoundingBox: BoundingBox {
    
    public let minX: Double
    public let maxX: Double
    public let minY: Double
    public let maxY: Double
    
    public init(minX: Double, maxX: Double, minY: Double, maxY: Double) {
        self.minX = minX
        self.maxX = maxX
        self.minY = minY
        self.maxY = maxY
    }
    
    public func intersects(_ other: any Coordinate) -> Bool {
        return !(other.x > maxX ||
                 other.x < minX ||
                 other.y > maxY ||
                 other.y < minY)
    }
    
    public func intersects(x: Double, y: Double) -> Bool {
        return !(x > maxX ||
                 x < minX ||
                 y > maxY ||
                 y < minY)
    }
    
    public func intersects(_ other: BoundingBox) -> Bool {
        return !(other.minX > maxX ||
                 other.maxX < minX ||
                 other.minY > maxY ||
                 other.maxY < minY)
    }
    
    public func grow(factor: Double) -> BoundingBox {
        let w = maxX - minX
        let h = maxY - minY
        let dx = ((factor * w) - w) / 2
        let dy = ((factor * h) - h) / 2
        return DefaultBoundingBox(
            minX: minX - dx,
            maxX: maxX + dx,
            minY: minY - dy,
            maxY: maxY + dy
        )
    }
    
    public func grow(deltaX: Double, deltaY: Double) -> BoundingBox {
        return DefaultBoundingBox(
            minX: minX - deltaX,
            maxX: maxX + deltaX,
            minY: minY - deltaY,
            maxY: maxY + deltaY
        )
    }
    
    public func transform(_ transform: (any Coordinate) -> any Coordinate) -> DefaultBoundingBox {
        let min = DefaultCoordinate2D(x: minX, y: minY)
        let max = DefaultCoordinate2D(x: maxX, y: maxY)
        let newMin = transform(min)
        let newMax = transform(max)
        return DefaultBoundingBox(minX: newMin.x, maxX: newMax.x, minY: newMin.y, maxY: newMax.y)
    }
    
    public static func create(_ coords: [any Coordinate]) -> BoundingBox? {
        if coords.isEmpty {
            return nil
        }
        
        if coords.count == 1, let c = coords.first {
            return DefaultBoundingBox(minX: c.x, maxX: c.x, minY: c.y, maxY: c.y)
        }
        
        var minX: Double? = nil
        var maxX: Double? = nil
        var minY: Double? = nil
        var maxY: Double? = nil
        
        for c in coords {
            minX = min(minX ?? c.x, c.x)
            maxX = max(maxX ?? c.x, c.x)
            minY = min(minY ?? c.y, c.y)
            maxY = max(maxY ?? c.y, c.y)
        }
        
        if let minX, let maxX, let minY, let maxY {
            return DefaultBoundingBox(minX: minX, maxX: maxX, minY: minY, maxY: maxY)
        }
        
        return nil
    }
    
    public static func create(_ boundingBoxes: [BoundingBox]) -> BoundingBox? {
        if boundingBoxes.isEmpty {
            return nil
        }
        
        if boundingBoxes.count == 1 {
            return boundingBoxes.first
        }
        
        var minX: Double? = nil
        var maxX: Double? = nil
        var minY: Double? = nil
        var maxY: Double? = nil
        
        for bbox in boundingBoxes {
            minX = min(minX ?? bbox.minX, bbox.minX)
            maxX = max(maxX ?? bbox.maxX, bbox.maxX)
            minY = min(minY ?? bbox.minY, bbox.minY)
            maxY = max(maxY ?? bbox.maxY, bbox.maxY)
        }
        
        if let minX, let maxX, let minY, let maxY {
            return DefaultBoundingBox(minX: minX, maxX: maxX, minY: minY, maxY: maxY)
        }
        
        return nil
    }
    
}
