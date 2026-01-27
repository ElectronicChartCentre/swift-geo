//
//  File.swift
//  swift-s100-portrayal
//

import Foundation

public struct ScreenResolution {
    
    private let pixelsPrInch: Double
    private let pixelsPrMeter: Double
    
    public init(pixelsPrPoint: Int) {
        pixelsPrInch = Double(pixelsPrPoint * 72)
        pixelsPrMeter = pixelsPrInch / 0.0254
    }
    
    public func pixels(mm: Double) -> Double {
        return pixelsPrMeter / 1000.0 * mm
    }
    
}
