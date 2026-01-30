//
//  File.swift
//  swift-s101
//

import Foundation

public protocol MultiGeometry: Geometry {
    
    func geometries() -> [Geometry]
    
}
