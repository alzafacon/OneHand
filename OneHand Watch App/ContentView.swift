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
            Image("hourHand")
            Text(getTime())
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

#Preview {
    ContentView()
}
