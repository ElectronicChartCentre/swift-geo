//
//  File.swift
//  swift-s101
//

import Foundation

public protocol Point: Geometry {
    
    var coordinate: any Coordinate { get }
    
}
