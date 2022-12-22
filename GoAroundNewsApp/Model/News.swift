//
//  News.swift
//  GoAroundNewsApp
//
//  Created by Dyana Varghese on 18/12/22.
//

import Foundation

struct News: Codable, Identifiable {
    var id: UUID = UUID()
    let author, content, description: String?
    let publishedAt: String
    let source: Source
    let title: String
    let url: String
    let urlToImage: String?
    
    enum CodingKeys: String, CodingKey {
        case author, content, description, publishedAt, source, title, url, urlToImage
    }
}

// MARK: - Source
struct Source: Codable, Identifiable {
    let id: String?
    let name: String
}

extension News {
    static var sample: News {
        News(author: "Lauren Fox, Daniella Diaz, Jeremy Herb", content: "The House Ways and Means Committee is meeting to discuss former President Donald Trumps tax returns and weigh whether to release the information to the public, the end to a years-long effort from Dem… [+5736 chars]", description: "The House Ways and Means Committee is meeting to discuss former President Donald Trump's tax returns and weigh whether to release the information to the public, the end to a years-long effort from Democrats to learn more about Trump's financial background.", publishedAt: "12th Dec 2022", source: Source(id: "cnn", name: "CNN"), title: "House Ways and Means Committee is meeting on future of Trump's tax returns - CNN", url: "https://www.cnn.com/2022/12/20/asia/taliban-bans-women-university-education-intl/index.html", urlToImage: "https://media.cnn.com/api/v1/images/stellar/prod/221220130416-01-afghanistan-taliban-education.jpg?c=16x9&q=w_800,c_fill")
    }
}
