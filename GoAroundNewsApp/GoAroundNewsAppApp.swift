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
    @StateObject var newsBookmarkVM = BookmarkViewModel.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(isDarkModeOn ? .dark : .light)
                .environmentObject(newsBookmarkVM)
        }
    }
}
