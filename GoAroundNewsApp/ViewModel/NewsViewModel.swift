//
//  HomeViewModel.swift
//  GoAroundNewsApp
//
//  Created by Dyana Varghese on 15/12/22.
//

import Foundation
import Combine

class NewsViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var searchText: String = ""
    private var networkService: NetworkServiceProtocol
    private var bag: [AnyCancellable] = []
    @Published var news: [News] = []
    @Published var savedNews: [News] = []
    @Published var selectedCategory: NewsCategory = .general
    @Published var selectedNews: News?
    var bookmarkNewsStore = BookmarkStore()
    
    var filteredNews: [News] {
        searchText.isEmpty ? news : news.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
    }
    
    var searchNews: [News] {
        searchText.isEmpty ? [] : news
    }
    
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchTopNews(country: NewsCountry, category: NewsCategory, completion: @escaping () -> Void) {
        isLoading = true
        self.networkService.execute(API.getTopNews(country: country, category: category)) { [weak self] (result: Result<[News], ServiceError>) in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success(let news):
                self.news = news
                completion() // for test case
            case .failure:
                completion()// for test case
            }
        }.store(in: &bag)
    }
    
    func searchNews(with query: String, completion: @escaping () -> Void) {
        isLoading = true
        self.networkService.execute(API.getNewsOnSearch(text: query)) { [weak self] (result: Result<[News], ServiceError>) in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success(let news):
                self.news = news
                completion() // for test case
            case .failure:
                self.news = []
                completion()// for test case
            }
        }.store(in: &bag)
    }
}
