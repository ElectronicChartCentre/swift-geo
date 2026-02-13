//
//  Test.swift
//  swift-geo
//

import Testing

@testable import SwiftGeo

struct AngleTests {
    
    @Test func testNorthDegreesToMathRadians() async {
        #expect(Angle.northDegreesToMathRadians(0) == .pi / 2)
        #expect(Angle.northDegreesToMathRadians(90) == 0)
        #expect(Angle.northDegreesToMathRadians(180) == .pi / -2)
        #expect(Angle.northDegreesToMathRadians(225) == .pi * -0.75)
        #expect(Angle.northDegreesToMathRadians(315) == .pi * 0.75)
    }

    @Test func testMathRadiansToNorthDegrees() async {
        #expect(Angle.mathRadiansToNorthDegrees(.pi / 2) == 0)
        #expect(Angle.mathRadiansToNorthDegrees(0) == 90)
        #expect(Angle.mathRadiansToNorthDegrees(.pi / -2) == 180)
        #expect(Angle.mathRadiansToNorthDegrees(.pi * -0.75) == 225)
        #expect(Angle.mathRadiansToNorthDegrees(.pi * 0.75) == 315)
    }
    
    @Test func testAbsoluteDifference() async {
        let d11 = Angle(degreesCWNorth: 11)
        let d21 = Angle(degreesCWNorth: 21)
        #expect(e(d11.absoluteDifference(d21).degrees(), 10.0))
    }
    
    func e(_ d0: Double, _ d1: Double) -> Bool {
        let tolerance = 0.000001
        return abs(d0 - d1) < tolerance
    }

}
