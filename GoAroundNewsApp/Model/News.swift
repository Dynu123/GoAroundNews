//
//  News.swift
//  GoAroundNewsApp
//
//  Created by Dyana Varghese on 18/12/22.
//

import Foundation

struct News: Codable {
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
struct Source: Codable {
    let id: String?
    let name: String
}
