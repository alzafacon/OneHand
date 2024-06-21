//
//  ContentView.swift
//  OneHand Watch App
//
//  Created by Fidel Coria on 6/14/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        let hour = 7.0
        let minute = 45.0
        let timeAngle = calcTimeDegrees(hour: hour, minute: minute)
        
        // calculations are relative to viewSize
        let viewSize = 118.0 // value from svg sizes
        let radius = viewSize / 2
        let zoom = 0.95; // [0,1). 1 means the diameter of the viewport is congruent with a tangent to the clock face
        let chordOffset = getChordOffset(zoom: zoom, radius: radius)
        let scaleFactor = getScaleFactor(chordOffset: chordOffset, radius: radius)
        
        let dx = scaleFactor * getDeltaX(chordOffset: chordOffset, timeDegrees: timeAngle)
        let dy = scaleFactor * getDeltaY(chordOffset: chordOffset, timeDegrees: timeAngle)
        // yes, the x and y are flipped and there is a negative sign intentionally
        let translation = CGAffineTransform(translationX: -dy, y: dx)

        ZStack {
            Image("clockFace")
                .scaleEffect(CGSize(width: scaleFactor, height: scaleFactor))
                .transformEffect(translation)
            Image("hourHand")
                .rotationEffect(.degrees(timeAngle))
                .scaleEffect(CGSize(width: scaleFactor, height: scaleFactor))
                .transformEffect(translation)
                
        }
        .padding()
    }
}

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

#Preview {
    ContentView()
}
