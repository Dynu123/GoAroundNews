//
//  NewsSearchTests.swift
//  GoAroundNewsAppTests
//
//  Created by Dyana Varghese on 03/01/23.
//

import XCTest
@testable import GoAroundNewsApp

final class NewsSearchTests: XCTestCase {
    let newsVM = NewsViewModel(networkService: NetworkService())
    let news = Array(repeating: News.sample, count: 5)
    
    func test_news_search_when_search_empty() {
        newsVM.searchText = ""
        newsVM.news = news
        XCTAssertEqual(newsVM.filteredNews.count, news.count)
    }
    
    func test_news_search_when_search_notEmpty() {
        newsVM.searchText = "hello"
        newsVM.news = news
        XCTAssertNotEqual(newsVM.filteredNews.count, news.count)
        XCTAssertLessThan(newsVM.filteredNews.count, news.count)
    }
}
