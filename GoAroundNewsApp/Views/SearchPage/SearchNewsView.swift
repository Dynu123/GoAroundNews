//
//  SearchNewsView.swift
//  GoAroundNewsApp
//
//  Created by Dyana Varghese on 22/12/22.
//

import SwiftUI

struct SearchNewsView: View {
    @StateObject var newsVM = NewsViewModel(networkService: NetworkService())
    
    var body: some View {
        NavigationStack {
            VStack {
                if newsVM.searchNews.isEmpty {
                    NoDataView(searchText: $newsVM.searchText)
                } else {
                    List(newsVM.searchNews, id: \.id) { news in
                        NewsRowView(news: news)
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets())
                            .onTapGesture {
                                newsVM.selectedNews = news
                            }
                            .swipeActions(){
                                Button {
                                    print("save")
                                } label: {
                                    Image(systemName: "bookmark")
                                        .foregroundColor(Color.theme)
                                    
                                }
                                //.tint(.white)
                            }
                            .swipeActions(){
                                Button(action: {
                                    presentShareSheet(url: URL(string: news.url)!)
                                }) {
                                    Image(systemName: "square.and.arrow.up")
                                }
                                .tint(.theme)
                            }
                    }
                    .listStyle(.plain)
                }
            }
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
}

struct SearchNewsView_Previews: PreviewProvider {
    static var previews: some View {
        SearchNewsView()
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
