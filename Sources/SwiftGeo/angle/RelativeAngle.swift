//
//  File.swift
//  swift-geo
//

import Foundation

public struct RelativeAngle {
    
    public let radians: Double
    
    public init(radians: Double) {
        self.radians = radians
    }
    
    public init(degrees: Double) {
        self.radians = degrees * .pi / 180.0
    }
    
    public func degrees() -> Double {
        return radians * 180.0 / .pi
    }
    
}
