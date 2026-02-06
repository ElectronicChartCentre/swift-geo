//
//  File.swift
//  swift-s100-portrayal
//

import Foundation

public struct LLXYProjection: Projection {
    
    private let bbox: BoundingBox
    private let widthPixel: Double
    private let heightPixel: Double
    
    public init(bbox: BoundingBox, widthPoint: Int, heightPoint: Int, pixelsPrPoint: Int) {
        self.bbox = bbox
        self.widthPixel = Double(widthPoint * pixelsPrPoint)
        self.heightPixel = Double(heightPoint * pixelsPrPoint)
    }

    public func forward(coordinate: any Coordinate) -> any Coordinate {
        let screenX = ((coordinate.x - bbox.minX) / (bbox.maxX - bbox.minX)) * Double(widthPixel)
        let screenY = ((coordinate.y - bbox.minY) / (bbox.maxY - bbox.minY)) * Double(heightPixel)
        return coordinate.transform(newX: screenX, newY: screenY)
    }
    
    public func inverse(coordinate: any Coordinate) -> any Coordinate {
        let worldX = (coordinate.x / widthPixel) * (bbox.maxX - bbox.minX) + bbox.minX
        let worldY = (coordinate.y / heightPixel) * (bbox.maxY - bbox.minY) + bbox.minY
        return coordinate.transform(newX: worldX, newY: worldY)
    }
    
    public func forward(geometry: Geometry) -> Geometry {
        return geometry.transform(forward)
    }
    
    public func inverse(geometry: Geometry) -> Geometry {
        return geometry.transform(inverse)
    }
    
}
