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
    @Published var selectedCategory: NewsCategory = .general
    @Published var selectedCountry: NewsCountry = .Ireland
    
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    
    func fetchNews(country: NewsCountry, category: NewsCategory, completion: @escaping () -> Void) {
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
}
