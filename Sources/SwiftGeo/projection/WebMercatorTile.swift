//
//  File.swift
//  swift-geo
//

import Foundation

/**
 * EPSG:3857 with XYZ tiling.
 */
public struct WebMercatorTile: Projection {
    
    private static let radius: Double = 6378137.0
    private static let startResolution: Double = 156543.0339
    private static let left: Double = -2.003750834E7
    private static let top: Double = 2.0037508E7
    
    private let widthPoint = 256
    private let heightPoint = 256
    private let widthPixel: Int
    private let heightPixel: Int

    public let x: Int
    public let y: Int
    public let z: Int
    public let pixelRatio: Int
    
    private let mapUnitsPrPoint: Double
    private let mapUnitsPrPixel: Double
    
    private let tileWidthInMapUnits: Double
    private let tileHeightInMapUnits: Double
    
    private let minX: Double
    private let minY: Double

    public init(x: Int, y: Int, z: Int, pixelRatio: Int) {
        self.x = x
        self.y = y
        self.z = z
        self.pixelRatio = pixelRatio
        
        self.widthPixel = widthPoint * pixelRatio
        self.heightPixel = heightPoint * pixelRatio
        
        self.mapUnitsPrPoint = WebMercatorTile.startResolution * pow(0.5, Double(z));
        self.mapUnitsPrPixel = mapUnitsPrPoint / Double(pixelRatio)
        
        self.tileWidthInMapUnits = mapUnitsPrPixel * Double(widthPixel)
        self.tileHeightInMapUnits = mapUnitsPrPixel * Double(heightPixel)
        
        self.minX = WebMercatorTile.left + (Double(x) * tileWidthInMapUnits)
        self.minY = WebMercatorTile.top - (Double(y) * tileHeightInMapUnits)
    }

    public func forward(coordinate: any Coordinate) -> any Coordinate {
        
        let latRad = coordinate.y * .pi / 180.0
        let lonRad = coordinate.x * .pi / 180.0
        
        // http://wiki.openstreetmap.org/wiki/Mercator
        let mapY = log(tan(latRad / 2.0 + .pi / 4.0)) * WebMercatorTile.radius
        let mapX = lonRad * WebMercatorTile.radius

        let pixelX = (mapX - minX) / mapUnitsPrPixel
        let pixelY = Double(heightPixel) - 1.0 - ((mapY - minY) / -mapUnitsPrPixel)

        return coordinate.transform(newX: pixelX, newY: pixelY)
    }
    
    public func inverse(coordinate: any Coordinate) -> any Coordinate {
        
        let mapX = (coordinate.x * mapUnitsPrPixel) + minX
        let mapY = ((coordinate.y - Double(heightPixel) + 1.0) * mapUnitsPrPixel) + minY
        
        // http://wiki.openstreetmap.org/wiki/Mercator
        let latRad = 2.0 * atan(exp(mapY / 6378137.0)) - .pi / 2.0;
        let lonRad = mapX / 6378137.0;

        let lat = latRad * 180.0 / .pi
        let lon = lonRad * 180.0 / .pi
        
        return coordinate.transform(newX: lon, newY: lat)
    }
    
    public func forward(geometry: any Geometry) -> any Geometry {
        return geometry.transform(self.forward)
    }
    
    public func inverse(geometry: any Geometry) -> any Geometry {
        return geometry.transform(self.inverse)
    }
    
}
