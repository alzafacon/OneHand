//
//  ContentView.swift
//  OneHand Watch App
//
//  Created by Fidel Coria on 6/14/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        // TODO verify assumption: svg fills viewSize size area
        
        let hour = 12.0
        let minute = 0.0
        let timeAngle = calcTimeDegrees(hour: hour, minute: minute)
        
        // calculations are relative to viewSize
        let viewSize = 200.0
        let radius = viewSize / 2
        let zoom = 0; // [0,1]. 1 means the diameter of the viewport is congruent with a tangent to the clock face
        let chordOffset = getChordOffset(zoom: radius, radius: radius)
        let scaleFactor = getScaleFactor(chordOffset: chordOffset, radius: radius)
        
        let dx = getDeltaX(chordOffset: scaleFactor * chordOffset, timeDegrees: timeAngle)
        let dy = getDeltaY(chordOffset: scaleFactor * chordOffset, timeDegrees: timeAngle)
        
        ZStack {
            Image("clockFace")
                .frame(width: viewSize, height: viewSize, alignment: .center)
                .scaleEffect(CGSize(width: scaleFactor, height: scaleFactor))
            Image("hourHand")
                .scaleEffect(CGSize(width: scaleFactor, height: scaleFactor))
                .rotationEffect(.degrees(timeAngle))
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
