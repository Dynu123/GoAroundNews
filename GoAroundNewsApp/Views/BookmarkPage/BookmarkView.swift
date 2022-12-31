//
//  BookmarkView.swift
//  GoAroundNewsApp
//
//  Created by Dyana Varghese on 22/12/22.
//

import SwiftUI

struct BookmarkView: View {
    @EnvironmentObject var newsBookmarkVM: BookmarkViewModel
    @StateObject var newsVM = NewsViewModel(networkService: NetworkService())
    
    var body: some View {
        NavigationStack {
            //ZStack {
                List {
                    ForEach(newsBookmarkVM.filteredNews, id: \.id) { news in
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
                .overlay(overlayView())
           // }
            .navigationTitle("Favourites")
            .navigationBarTitleDisplayMode(.large)
            .searchable(text: $newsBookmarkVM.searchText)
            .sheet(item: $newsVM.selectedNews) { selectedNews in
                SafariView(url: URL(string: selectedNews.url)!)
            }
        }
    }
    
    @ViewBuilder
    func overlayView() -> some View {
        if newsBookmarkVM.filteredNews.isEmpty {
            NoDataPlaceholderView(text: "No saved articles", image: Image(systemName: "heart"))
        }
    }
}

