//
//  File.swift
//  swift-s101
//

import Foundation

public protocol MultiGeometry: Geometry {
    
    func numGeometries() -> Int
    
    func geometry(_ idx: Int) -> Geometry
    
}
