//
//  SearchNewsView.swift
//  GoAroundNewsApp
//
//  Created by Dyana Varghese on 22/12/22.
//

import SwiftUI

struct SearchNewsView: View {
    @EnvironmentObject var newsBookmarkVM: BookmarkViewModel
    @StateObject var newsVM = NewsViewModel(networkService: NetworkService())
    
    var body: some View {
        NavigationStack {
            List(newsVM.searchNews, id: \.id) { news in
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
            .listStyle(.plain)
            .overlay(overlayView)
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle("Search")
        }
        .searchable(text: $newsVM.searchText)
        .onSubmit(of: .search) {
            newsVM.news = []
            newsVM.searchNews(with: newsVM.searchText) {}
        }
        .sheet(item: $newsVM.selectedNews) { selectedNews in
            SafariView(url: URL(string: selectedNews.url)!)
        }
    }
    
    @ViewBuilder
    private var overlayView: some View {
        switch newsVM.viewState1 {
        case .loading, .loadingMore:
            LoaderView()
        case .success(let news) where news.isEmpty:
            NoDataPlaceholderView(text: "No matching articles found", image: nil)
        case .failure(let error):
            RetryView(text: error.localizedDescription) {
                newsVM.searchNews(with: newsVM.searchText) {}
            }
        case .noData(let message):
            NoDataPlaceholderView(text: message, image: Image(systemName: "magnifyingglass"))
        default: EmptyView()
        }
    }
}

struct NoDataView: View {
    @Binding var searchText: String
    
    private var text: Binding<String> {
        return Binding<String>(
            get: {
                self.searchText
            }, set: {
                self.searchText = $0
            } )
    }
    
    
    var body: some View {
        VStack {
            Spacer()
            Text(searchText.isEmpty ? "Search for news from all over the world, hit enter to start searching" : "No matching records found")
                .padding(.all)
                .foregroundColor(.secondary)
                .font(.system(.body, design: .rounded))
            Spacer()
        }
        
    }
}
