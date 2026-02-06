//
//  File.swift
//  swift-s101
//

import Foundation

public protocol Coordinate: Equatable {
    
    var x: Double { get }
    
    var y: Double { get }
    
    func isEqual(to other: (any Coordinate)?) -> Bool
    
    func transform(newX: Double, newY: Double) -> Self
    
    func distance2D(to other: (any Coordinate)) -> Double
    
}
