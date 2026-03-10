//
//  File.swift
//  swift-s101
//

import Foundation

public protocol Geometry: Sendable {
    
    func isEmpty() -> Bool
    
    func isValid() -> Bool
    
    func bbox() -> BoundingBox?
    
    func transform(_ transform: (any Coordinate) -> (any Coordinate)) -> Self
    
}
