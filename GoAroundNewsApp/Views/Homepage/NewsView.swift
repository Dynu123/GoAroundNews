//
//  HomeView.swift
//  GoAroundNewsApp
//
//  Created by Dyana Varghese on 13/12/22.
//

import SwiftUI

struct NewsView: View {
    @StateObject var newsVM = NewsViewModel(networkService: NetworkService())
    @EnvironmentObject var newsBookmarkVM: BookmarkViewModel
    @AppStorage("selectedCountry") private var selectedCountry = NewsCountry.Ireland
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(alignment: .leading) {
                    CountryListView().hidden()
                    CategoryView(selectedCategory: $newsVM.selectedCategory)
                    ZStack {
                        List {
                            ForEach(newsVM.filteredNews, id: \.id) { news in
                                NewsRowView(news: news)
                                    .listRowSeparator(.hidden)
                                    .listRowInsets(EdgeInsets())
                                    .onTapGesture {
                                        newsVM.selectedNews = news
                                    }
                                    .swipeActions(edge: .leading){
                                        Button {
                                            withAnimation {
                                                newsBookmarkVM.toggleSaved(item: news)
                                            }
                                        } label: {
                                            Image(systemName: "heart.fill" )
                                                .resizable()
                                                .frame(width: 50, height:50)
                                        }
                                        .tint(newsBookmarkVM.isSaved(item: news) ? .red : .red.opacity(0.3) )
                                    }
                                    .swipeActions(edge: .trailing) {
                                        Button(action: {
                                            presentShareSheet(url: URL(string: news.url)!)
                                        }) {
                                            Image(systemName: "square.and.arrow.up")
                                        }
                                        .tint(.theme)
                                    }
                            }
                        }
                        .listStyle(.plain)
                        
                        if newsVM.isLoading {
                            LoaderView()
                        }
                    }
                }
            }
            .navigationTitle("Discover")
            .navigationBarTitleDisplayMode(.large)
        }
        .onAppear() {
            newsVM.fetchTopNews(country: selectedCountry, category: newsVM.selectedCategory) {}
        }
        .searchable(text: $newsVM.searchText)
        .onChange(of: newsVM.selectedCategory, perform: { newValue in
            newsVM.fetchTopNews(country: selectedCountry, category: newsVM.selectedCategory) {}
        })
        .onChange(of: selectedCountry, perform: { newValue in
            newsVM.fetchTopNews(country: selectedCountry, category: newsVM.selectedCategory) {}
        })
        .sheet(item: $newsVM.selectedNews) { selectedNews in
            SafariView(url: URL(string: selectedNews.url)!)
        }
        .refreshable {
            newsVM.fetchTopNews(country: selectedCountry, category: newsVM.selectedCategory) {}
        }
    }
}


