//
//  NewsRowView.swift
//  GoAroundNewsApp
//
//  Created by Dyana Varghese on 21/12/22.
//

import SwiftUI

struct NewsRowView: View {
    var news: News
    
    init(news: News) {
        self.news = news
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 16) {
                AsyncImage(url: URL(string: news.urlToImage ?? ""), content: { image in
                    image.resizable()
                }, placeholder: {
                    LoaderView()
                })
                .frame(width: 100, height: 100)
                .scaledToFill()
                .cornerRadius(10)
                .shadow(color: .primary.opacity(0.5), radius: 2)
                VStack(alignment: .leading, spacing: 3) {
                    Text(news.title)
                        .font(.system(.headline, design: .rounded, weight: .semibold))
                    Text(news.publishedAt.relative)
                        .font(.system(.subheadline, design: .rounded, weight: .semibold))
                        .foregroundColor(Color(UIColor.tertiaryLabel))
                        .padding(.bottom, 10)
                    Text("Source: \(news.source.name)")
                        .font(.system(.subheadline, design: .rounded, weight: .semibold))
                        .foregroundColor(Color(UIColor.tertiaryLabel))
                }
            }
        }
        .padding(16)
    }
}

struct NewsRowView_Previews: PreviewProvider {
    static var previews: some View {
        NewsRowView(news: .sample).environmentObject(NewsViewModel(networkService: NetworkService()))
    }
}
