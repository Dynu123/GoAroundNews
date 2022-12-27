//
//  HomeView.swift
//  GoAroundNewsApp
//
//  Created by Dyana Varghese on 13/12/22.
//

import SwiftUI

struct NewsView: View {
    @StateObject var newsVM = NewsViewModel(networkService: NetworkService())
    @AppStorage("selectedCountry") private var selectedCountry = NewsCountry.Ireland
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(alignment: .leading) {
                    CountryListView().hidden()
                    CategoryView(selectedCategory: $newsVM.selectedCategory)
                    ZStack {
                        List(newsVM.filteredNews, id: \.id) { news in
                            NewsRowView(news: news)
                                .listRowSeparator(.hidden)
                                .listRowInsets(EdgeInsets())
                                .onTapGesture {
                                    newsVM.selectedNews = news
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
    }
}

