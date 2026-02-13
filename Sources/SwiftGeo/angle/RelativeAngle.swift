//
//  File.swift
//  swift-geo
//

import Foundation

public struct RelativeAngle {
    
    public let radians: Double
    
    public func degrees() -> Double {
        return radians * 180.0 / .pi
    }
    
}
