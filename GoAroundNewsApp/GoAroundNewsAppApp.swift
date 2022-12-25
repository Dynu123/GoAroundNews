//
//  GoAroundNewsAppApp.swift
//  GoAroundNewsApp
//
//  Created by Dyana Varghese on 07/12/22.
//

import SwiftUI

@main
struct GoAroundNewsAppApp: App {
    @AppStorage("appTheme") private var isDarkModeOn = false
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(isDarkModeOn ? .dark : .light)
        }
    }
}
