//
//  ContentView.swift
//  GoAroundNewsApp
//
//  Created by Dyana Varghese on 07/12/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var loginVM = LoginViewModel(networkService: NetworkService(), credential: Credential())
    @StateObject private var newsVM = NewsViewModel(networkService: NetworkService())
    
    var body: some View {
        if loginVM.isUserLoggedIn {
            BottomTabBarView()
                .environmentObject(loginVM)
                .environmentObject(newsVM)
        } else {
            LoginView()
        }
    }
}

