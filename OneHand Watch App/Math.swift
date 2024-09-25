//
//  Math.swift
//  OneHand Watch App
//
//  Created by Fidel Coria on 9/24/24.
//

import Foundation

func calcTimeDegrees(hour: Double, minute: Double) -> Double {
    // let pole lay on positive y-axis to start angle calculation
    var time = 0.0
    // advance hour
    time += hour * 30 // 30 degrees in 1 hour
    // advance minute
    time += minute * 0.5 // 0.5 degress in 1 minute

    return time
}

// distance vetween viewport center and chord midpoint
func getChordOffset(zoom: Double, radius: Double) -> Double {
    // zoom: [0,1]
    return zoom * radius
}

func getScaleFactor(chordOffset: Double, radius: Double) -> Double {
    return radius / getChordHalfLength(chordOffset: chordOffset, radius: radius)
}

func getChordHalfLength(chordOffset: Double, radius: Double) -> Double {
    // pythagorean theorem
    return sqrt(pow(radius,2) - pow(chordOffset,2))
}

func getDeltaX(chordOffset: Double, timeDegrees: Double) -> Double {
    return chordOffset * cos(degrees2Radians(degrees: timeDegrees))
}

func getDeltaY(chordOffset: Double, timeDegrees: Double) -> Double {
    return chordOffset * sin(degrees2Radians(degrees: timeDegrees))
}

func degrees2Radians(degrees: Double) -> Double {
    return degrees * .pi / 180
}
