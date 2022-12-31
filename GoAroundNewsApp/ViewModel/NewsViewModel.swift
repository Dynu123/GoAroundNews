//
//  HomeViewModel.swift
//  GoAroundNewsApp
//
//  Created by Dyana Varghese on 15/12/22.
//

import Foundation
import Combine

class NewsViewModel: ObservableObject {
    @Published var viewState = ViewState<[News]>.loading
    @Published var viewState1 = ViewState<[News]>.noData("Search for news from all over the world, hit enter to start searching")
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
        if searchText.isEmpty {
            DispatchQueue.main.async {
                self.viewState1 = .noData("Search for news from all over the world, hit enter to start searching")
            }
            return []
        }
        return news
    }
    
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
  
    
    func fetchTopNews(country: NewsCountry, category: NewsCategory, completion: @escaping () -> Void) {
        viewState = .loading
        self.networkService.execute(API.getTopNews(country: country, category: category)) { [weak self] (result: Result<[News], ServiceError>, statusCode) in
            guard let self = self else { return }
            switch result {
            case .success(let news):
                self.viewState = .success(news)
                self.news = news
                completion() // for test case
            case .failure(let error):
                self.viewState = .failure(error)
                completion()// for test case
            }
        }
    }
    
    func searchNews(with query: String, completion: @escaping () -> Void) {
        viewState1 = .loading
        self.networkService.execute(API.getNewsOnSearch(text: query)) { [weak self] (result: Result<[News], ServiceError>, statusCode) in
            guard let self = self else { return }
            switch result {
            case .success(let news):
                self.viewState1 = .success(news)
                self.news = news
                completion() // for test case
            case .failure(let error):
                self.viewState1 = .failure(error)
                self.news = []
                completion()// for test case
            }
        }
    }
}
