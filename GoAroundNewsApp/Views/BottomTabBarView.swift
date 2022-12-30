//
//  BottomTabBarView.swift
//  GoAroundNewsApp
//
//  Created by Dyana Varghese on 22/12/22.
//

import SwiftUI

struct BottomTabBarView: View {
    @EnvironmentObject var loginVM: LoginViewModel
    
    var body: some View {
        TabView {
            NewsView()
                .tabItem {
                    Label("News", systemImage: "newspaper")
                }
            SearchNewsView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            BookmarkView()
                .tabItem {
                    Label("Favourites", systemImage: "heart")
                }
            ProfileView()
                .tabItem {
                    Label("Account", systemImage: "person.crop.circle")
                }
        }
    }
}

struct BottomTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        BottomTabBarView()
    }
}
