//
//  File.swift
//  swift-geo
//

import Foundation

public protocol MultiPoint: MultiGeometry {
    
    var coordinates: any CoordinateSequence { get }

}
