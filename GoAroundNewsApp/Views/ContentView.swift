//
//  ContentView.swift
//  GoAroundNewsApp
//
//  Created by Dyana Varghese on 07/12/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = LoginViewModel(networkService: NetworkService(), credential: Credential())
    var body: some View {
        if viewModel.isUserLoggedIn {
            HomeView()
                .environmentObject(viewModel)
        } else {
            LoginView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
