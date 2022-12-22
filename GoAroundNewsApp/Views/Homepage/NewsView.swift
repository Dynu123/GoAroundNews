//
//  HomeView.swift
//  GoAroundNewsApp
//
//  Created by Dyana Varghese on 13/12/22.
//

import SwiftUI

struct NewsView: View {
    @EnvironmentObject var loginVM: LoginViewModel
    @StateObject var newsVM = NewsViewModel(networkService: NetworkService())
    @State private var selectedNews: News?
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(alignment: .leading) {
                    TitleBarView()
                    SearchBarView(text: $newsVM.searchText)
                    CategoryView(selectedCategory: $newsVM.selectedCategory)
                    //                    Button("Logout") {
                    //                        LocalStorage.user = nil
                    //                        loginVM.isUserLoggedIn = false
                    //                        loginVM.showHome = false
                    //                    }
                    ZStack {
                        List(newsVM.news.filter({ newsVM.searchText.isEmpty ? true : $0.title.lowercased().contains(newsVM.searchText.lowercased()) }), id: \.id) { news in
                            NewsRowView(news: news)
                                .listRowSeparator(.hidden)
                                .listRowInsets(EdgeInsets())
                                .onTapGesture {
                                    selectedNews = news
                                }
                        }
                        .listStyle(.plain)
                        
                        if newsVM.isLoading {
                            LoaderView()
                        }
                    }
                }
            }
            .edgesIgnoringSafeArea([.horizontal, .bottom])
            .navigationBarBackButtonHidden()
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        //showProfile = true
                    } label: {
                        Image(systemName: "list.bullet")
                            .resizable()
                            .accentColor(Color.theme)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    CountryListView().environmentObject(newsVM)
                }
            }
        }
        .onAppear() {
            newsVM.fetchNews(country: newsVM.selectedCountry, category: newsVM.selectedCategory) {}
        }
        .onChange(of: newsVM.selectedCategory, perform: { newValue in
            newsVM.fetchNews(country: newsVM.selectedCountry, category: newsVM.selectedCategory) {}
        })
        .onChange(of: newsVM.selectedCountry, perform: { newValue in
            newsVM.fetchNews(country: newsVM.selectedCountry, category: newsVM.selectedCategory) {}
        })
        .sheet(item: $selectedNews) { selectedNews in
            SafariView(url: URL(string: selectedNews.url)!)
                .edgesIgnoringSafeArea(.bottom)
        }
    }
}

