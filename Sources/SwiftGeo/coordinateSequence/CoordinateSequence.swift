//
//  File.swift
//  swift-geo
//

import Foundation

public protocol CoordinateSequence: Collection<any Coordinate>, Sendable {
    
    subscript(_ index: Int) -> any Coordinate { get }
    
    func transform(_ transform: (any Coordinate) -> (any Coordinate)) -> Self
    
}
