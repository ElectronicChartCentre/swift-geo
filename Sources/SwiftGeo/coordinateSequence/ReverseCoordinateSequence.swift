//
//  File.swift
//  swift-geo
//

import Foundation

public struct ReverseCoordinateSequence: CoordinateSequence {
    
    public let cs: any CoordinateSequence
    public let startIndex: Int
    public let endIndex: Int

    public init(_ cs: any CoordinateSequence) {
        self.cs = cs
        self.startIndex = 0
        self.endIndex = cs.count
    }
    
    public func index(after i: Int) -> Int {
        return i + 1
    }
    
    public subscript(_ index: Int) -> any Coordinate {
        return cs[endIndex - 1 - index]
    }
    
    public func transform(_ transform: (any Coordinate) -> any Coordinate) -> ReverseCoordinateSequence {
        let newCs = cs.transform(transform)
        return ReverseCoordinateSequence(newCs)
    }

}
