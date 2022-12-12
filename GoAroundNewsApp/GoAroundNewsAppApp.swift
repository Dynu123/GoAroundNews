//
//  GoAroundNewsAppApp.swift
//  GoAroundNewsApp
//
//  Created by Dyana Varghese on 07/12/22.
//

import SwiftUI

@main
struct GoAroundNewsAppApp: App {
    var body: some Scene {
        WindowGroup {
            if let user = LocalStorage.user {
                //Home view
                Text("Home view, welcome \(user.email)")
            } else {
                LoginView()
            }
        }
    }
}
