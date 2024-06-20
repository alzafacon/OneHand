//
//  ContentView.swift
//  OneHand Watch App
//
//  Created by Fidel Coria on 6/14/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Image("clockFace")
                .scaleEffect(CGSize(width: 1.5, height: 1.5))
            Image("hourHand")
                .scaleEffect(CGSize(width: 1.5, height: 1.5))
                .rotationEffect(.degrees(calcTimeDegrees(hour: 1, minute: 45)))
        }
        .padding()
    }
}

func getTime() -> String {
    let formatter = DateFormatter()
    formatter.timeStyle = .short
    let dateString = formatter.string(from: Date())
    return dateString
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

#Preview {
    ContentView()
}
