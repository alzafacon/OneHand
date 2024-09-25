//
//  OneHandApp.swift
//  OneHand Watch App
//
//  Created by Fidel Coria on 6/14/24.
//

import SwiftUI

@main
struct OneHand_Watch_AppApp: App {
    var body: some Scene {
        WindowGroup {
            TimelineView(.periodic(from: .now, by: 1)) { currentTime in
                let hour = Double(Calendar.current.component(.hour, from: currentTime.date))
                let minute = Double(Calendar.current.component(.minute, from: currentTime.date))
               return ContentView(hour: hour, minute: minute)
            }
        }
    }
}
