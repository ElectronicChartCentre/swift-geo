//
//  File.swift
//  swift-geo
//

import Foundation

public struct GreatCircle {
    
    private static func deg2rad(_ number: Double) -> Double {
        return number * .pi / 180.0
    }
    
    private static func rad2deg(_ number: Double) -> Double {
        return number * 180.0 / .pi
    }
    
    private static func sphericalAzimuthPhi1(phi1: Double, lambda0: Double, phi: Double, lambda: Double) -> Double {
        let ldiff = lambda - lambda0
        let cosphi = cos(phi)
        return atan2(cosphi * sin(ldiff), (cos(phi1) * sin(phi) - sin(phi1) * cosphi * cos(ldiff)))
    }
    
    /**
     * Takes two Coordinate in lon lat and return a degree direction from first to last
     */
    public static func greatCircleBearing(from first: any Coordinate, to second: any Coordinate) -> Double {
        let r = sphericalAzimuthPhi1(phi1: deg2rad(first.y),
                                     lambda0: deg2rad(first.x),
                                     phi: deg2rad(second.y),
                                     lambda: deg2rad(second.x))
        let d = rad2deg(r)
        return d < 0 ? d + 360.0 : d
    }
    
    /**
     * start: Coordinate in lon lat.
     * distance: Double with distance in meters.
     * direction: Double with direction in degrees.
     * return a Coordinate distance away from start in direction.
     */
    public static func sphericalDestinationFrom(_ start: any Coordinate,
                                               distance: Double,
                                               direction: Double) -> any Coordinate {
        let phi1 = deg2rad(start.y)
        let lambda0 = deg2rad(start.x)
        let c = distance / 6378137.0 // distance in radians
        let Az = deg2rad(direction) // the angle in radians
        
        let cosphi1 = cos(phi1)
        let sinphi1 = sin(phi1)
        let cosAz = cos(Az)
        let sinAz = sin(Az)
        let sinc = sin(c)
        let cosc = cos(c)
        
        let lat = rad2deg(asin(sinphi1 * cosc + cosphi1 * sinc * cosAz))
        let lon = rad2deg(atan2(sinc * sinAz, cosphi1 * cosc - sinphi1 * sinc * cosAz)
                          + lambda0)
        return start.transform(newX: lon, newY: lat)
    }

    /**
     * Find ca meter great circle distance between two Coordinates in lon lat.
     *
     * copied from OpenMap GreatCircle.sphericalDistance
     */
    public static func sphericalDistance(from: any Coordinate, to: any Coordinate) -> Double {
        let phi1 = deg2rad(from.y)
        let lambda0 = deg2rad(from.x)
        let phi = deg2rad(to.y)
        let lambda = deg2rad(to.x)
        
        let pdiff = sin((phi - phi1) / 2.0)
        let ldiff = sin((lambda - lambda0) / 2.0)
        let rval = sqrt((pdiff * pdiff) + cos(phi1) * cos(phi) * (ldiff * ldiff))
        
        return 6378137.0 * 2.0 * asin(rval)
    }
    
    /**
     * Create a list of Coordinate
     *
     * copied from OpenMap GreatCircle.greatCircle
     */
    public static func greatCircleCoordinates(from: any Coordinate, to: any Coordinate) -> [any Coordinate] {
        let phi1 = deg2rad(from.y)
        let lambda0 = deg2rad(from.x);
        let phi = deg2rad(to.y)
        let lambda = deg2rad(to.x)
        let n = 50
        let include_last = true
        
        // number of points to generate
        let end = include_last ? n + 1 : n
        
        // calculate a bunch of stuff for later use
        let cosphi = cos(phi)
        let cosphi1 = cos(phi1)
        let sinphi1 = sin(phi1)
        let ldiff = lambda - lambda0
        let p2diff = sin(((phi - phi1) / 2.0))
        let l2diff = sin((ldiff) / 2.0)
        
        // calculate spherical distance
        var c = 2.0 * asin(sqrt(p2diff * p2diff + cosphi1 * cosphi * l2diff * l2diff))
        
        // calculate spherical azimuth
        let Az = atan2(cosphi * sin(ldiff), (cosphi1 * sin(phi) - sinphi1 * cosphi * cos(ldiff)))
        let cosAz = cos(Az)
        let sinAz = sin(Az)
        
        // generate the great circle line
        var coordinates: [any Coordinate] = []
        coordinates.append(from)
        
        let inc = c / Double(n)
        c = inc
        for _ in 1..<end {
            c = c + inc
            
            // partial constants
            let sinc = sin(c)
            let cosc = cos(c)
            
            // generate new point
            let latr = asin(sinphi1 * cosc + cosphi1 * sinc * cosAz)
            let lonr = atan2(sinc * sinAz, cosphi1 * cosc - sinphi1 * sinc * cosAz) + lambda0
            
            let coordinate = from.transform(newX: rad2deg(lonr), newY: rad2deg(latr))
            coordinates.append(coordinate)
        }
        
        return coordinates
    }
    
}
