//
//  HomeView.swift
//  GoAroundNewsApp
//
//  Created by Dyana Varghese on 13/12/22.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var loginVM: LoginViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Home view, welcome \(LocalStorage.user?.email ?? "")")
                .padding()
                Button("Logout") {
                    LocalStorage.user = nil
                    loginVM.isUserLoggedIn = false
                    loginVM.showHome = false
                }
            }
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
