//
//  File.swift
//  swift-s100-portrayal
//

import Foundation

public protocol Projection {
    
    /**
     * project from world x y to screen x y
     */
    func forward(coordinate: Coordinate) -> Coordinate
    
    /**
     * project from screen x y to world x y
     */
    func inverse(coordinate: Coordinate) -> Coordinate
    
    /**
     * project from world x y to screen x y
     */
    func forward(geometry: Geometry) -> Geometry
    
    /**
     * project from screen x y to world x y
     */
    func inverse(geometry: Geometry) -> Geometry
    
}
