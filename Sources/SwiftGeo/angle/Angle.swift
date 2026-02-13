//
//  File.swift
//  swift-geo
//

import Foundation

public struct Angle {
    
    private static let twopi = .pi * 2.0
    private static let halfpi = .pi / 2.0
    
    private let direction: Double
    
    public init(radiansCCWPositiveX: Double) {
        self.direction = radiansCCWPositiveX
    }
    
    public init(degreesCWNorth: Double) {
        self.direction = Angle.northDegreesToMathRadians(degreesCWNorth)
    }
    
    public func asRadiansCCWPositiveX() -> Double {
        return direction
    }
    
    public func asDegreesCWNorth() -> Double {
        return Angle.mathRadiansToNorthDegrees(direction)
    }
    
    public func absoluteDifference(_ other: Angle) -> RelativeAngle {
        let a = direction
        let b = other.direction
        let d = a < b ? b - a : a - b
        let dn = d > .pi ? Angle.twopi - d : d
        return RelativeAngle(radians: dn)
    }
    
    /**
     * Convert from degrees clockwise from north (positive y axis) to counter clockwise from east (positive x axis).
     */
    public static func northDegreesToMathRadians(_ degrees: Double) -> Double {
        let radiansFromNorth = degrees * .pi / 180.0
        let radiansFromX = (radiansFromNorth - halfpi) * -1.0
        // want +/- pi
        if radiansFromX < -.pi {
            return radiansFromX + twopi
        }
        if radiansFromX > .pi {
            return radiansFromX - twopi
        }
        return radiansFromX
    }

    /**
     * Convert from counter clockwise from east (positive x axis) to degrees clockwise from north (positive y axis).
     */
    public static func mathRadiansToNorthDegrees(_ radians: Double) -> Double {
        let degreesFromEastCCW = radians * 180.0 / .pi
        let degreesFromNorthCW = (degreesFromEastCCW - 90.0) * -1.0
        // want 0-360
        if degreesFromNorthCW < 0.0 {
            return degreesFromNorthCW + 360.0
        }
        if degreesFromNorthCW > 360.0 {
            return degreesFromNorthCW - 360.0
        }
        return degreesFromNorthCW
    }
    
}
