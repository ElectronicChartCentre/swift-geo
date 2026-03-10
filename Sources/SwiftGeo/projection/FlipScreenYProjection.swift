//
//  File.swift
//  swift-geo
//

import Foundation

public struct FlipScreenYProjection: Projection {
    
    public let widthPixel: Double
    
    public let heightPixel: Double
    
    public let wrappedProjection: Projection
    
    public init(wrappedProjection: Projection) {
        self.wrappedProjection = wrappedProjection
        self.widthPixel = wrappedProjection.widthPixel
        self.heightPixel = wrappedProjection.heightPixel
    }
    
    public func forward(coordinate: any Coordinate) -> any Coordinate {
        let screen = wrappedProjection.forward(coordinate: coordinate)
        return screen.transform(newX: screen.x, newY: heightPixel - 1.0 - screen.y)
    }
    
    public func inverse(coordinate: any Coordinate) -> any Coordinate {
        let screen = coordinate.transform(newX: coordinate.x, newY: heightPixel - 1.0 - coordinate.y)
        return wrappedProjection.inverse(coordinate: screen)
    }
    
    public func forward(coordinateSequence: any CoordinateSequence) -> any CoordinateSequence {
        return coordinateSequence.transform(self.forward)
    }
    
    public func inverse(coordinateSequence: any CoordinateSequence) -> any CoordinateSequence {
        return coordinateSequence.transform(self.inverse)
    }
    
    public func forward(geometry: any Geometry) -> any Geometry {
        return geometry.transform(self.forward)
    }
    
    public func inverse(geometry: any Geometry) -> any Geometry {
        return geometry.transform(self.inverse)
    }

}
