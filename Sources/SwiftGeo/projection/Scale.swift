//
//  File.swift
//  swift-geo
//

import Foundation

public struct Scale {
    
    /**
     * Calculate map scale. If the scale is 1:50K, this method will return 50K, not 1/50K.
     */
    public static func scale(projection: Projection, screenResolution: ScreenResolution) -> Double {
        
        // doing diagonal scale
        let screenA = DefaultCoordinate2D(x: projection.widthPixel * 0.25, y: projection.heightPixel * 0.25)
        let screenB = DefaultCoordinate2D(x: projection.widthPixel * 0.75, y: projection.heightPixel * 0.75)
        let worldA = projection.inverse(coordinate: screenA)
        let worldB = projection.inverse(coordinate: screenB)
        
        let screenDistancePixel = screenA.distance2D(to: screenB)
        let screenDistanceM = screenResolution.mm(pixels: screenDistancePixel) / 1000.0
        let worldDistanceM = GreatCircle.sphericalDistance(from: worldA, to: worldB)

        // opposite order to make 1:50K return as 50K instead of 1/50K.
        return worldDistanceM / screenDistanceM
    }
    
}
