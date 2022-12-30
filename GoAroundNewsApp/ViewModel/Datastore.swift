//
//  Datastore.swift
//  GoAroundNewsApp
//
//  Created by Dyana Varghese on 29/12/22.
//

import Foundation

protocol Datastore<T> {
    associatedtype T
    
    func load() -> T
    func save(item: T)
}

class BookmarkStore: Datastore {
    private var saved: T?
    
    func load() -> [News] {
        guard let news = LocalStorage.news else { return [] }
        self.saved = news
        return news
    }
    
    func save(item: [News]) {
        LocalStorage.news = item
        self.saved = item
    }
}

class BookmarkViewModel: ObservableObject {
    
    typealias T = [News]
    @Published var savedNews: [News] = []
    @Published var searchText: String = ""
    private let bookmarkStore = BookmarkStore()
    
    static let shared = BookmarkViewModel()
    
    private init() {
        Task {
            load()
        }
    }
    
    private func load() {
        DispatchQueue.main.async {
            self.savedNews = self.bookmarkStore.load()
        }
    }
    
    func isSaved(item: News) -> Bool {
        savedNews.contains(where: {$0.url == item.url})
    }
    
    func addSavedItem(item: News) {
        guard !isSaved(item: item) else {
            return
        }

        savedNews.insert(item, at: 0)
        saveUpdated()
    }
    
    func removeSavedItem(item: News) {
        guard let index = savedNews.firstIndex(where: { $0.url == item.url }) else {
            return
        }
        savedNews.remove(at: index)
        saveUpdated()
    }
    
    private func saveUpdated() {
        let news = self.savedNews
        Task {
            bookmarkStore.save(item: news)
        }
    }
    
    func toggleSaved(item: News) {
        if isSaved(item: item) {
            removeSavedItem(item: item)
        } else {
            addSavedItem(item: item)
        }
    }
    
    var filteredNews: [News] {
        searchText.isEmpty ? savedNews : savedNews.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
    }
 }
