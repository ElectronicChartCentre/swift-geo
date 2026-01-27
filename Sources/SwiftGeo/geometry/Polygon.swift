//
//  File.swift
//  swift-s101
//

import Foundation

public protocol Polygon: Geometry {
    
    var shell: LinearRing { get }
    var holes: [LinearRing] { get }
    
}
