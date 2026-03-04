//
//  File.swift
//  swift-s100-portrayal
//

import Foundation

/**
 * A projection from world lon(x) lat(y) to screen/tile x y. Screen x y origo is in lower left to match that of Core Graphics.
 */
public protocol Projection {
    
    var widthPixel: Double { get }
    var heightPixel: Double { get }
    
    /**
     * project from world x y to screen x y
     */
    func forward(coordinate: any Coordinate) -> any Coordinate
    
    /**
     * project from screen x y to world x y
     */
    func inverse(coordinate: any Coordinate) -> any Coordinate
    
    /**
     * project from world x y to screen x y
     */
    func forward(geometry: Geometry) -> Geometry
    
    /**
     * project from screen x y to world x y
     */
    func inverse(geometry: Geometry) -> Geometry
    
}
