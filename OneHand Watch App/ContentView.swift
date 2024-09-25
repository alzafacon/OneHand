//
//  ContentView.swift
//  OneHand Watch App
//
//  Created by Fidel Coria on 6/14/24.
//

import SwiftUI

struct ContentView: View {
    var hour: Double
    var minute: Double
    
    var body: some View {
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


#Preview {
    ContentView(hour: 1, minute: 30)
}

#Preview {
    ContentView(hour: 4, minute: 30)
}

#Preview {
    ContentView(hour: 7, minute: 30)
}

#Preview {
    ContentView(hour: 10, minute: 30)
}
