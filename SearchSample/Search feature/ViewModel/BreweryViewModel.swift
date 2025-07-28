//
//  BreweryViewModel.swift
//  SearchSample
//
//  Created by AH on 2025-07-26.
//

import Foundation

final class BreweryViewModel: ObservableObject {
    @Published private(set) var state = State.loadingList
    @Published var history: [(BreweryItem, Date)] = []
    @Published var selectedBrewery: BreweryItem?
    
    private let service: BreweryItemDataLoader
    private let store: BreweryItemsStore
    private var allResults: [BreweryItem] = []
    private(set) var isShowingAll = false
    
    init(service: BreweryItemDataLoader, store: BreweryItemsStore) {
        self.service = service
        self.store = store
    }
    
    func fetch(query: String? = nil) {
        guard let query = isValidQuery(query) else {
            state = .noQuery
            allResults = []
            isShowingAll = false
            return
        }
        
        state = .loadingList
        service.load(query: query) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let items):
                self.updateState(for: items)
            case .failure(let error):
                self.state = .error(self.errorMessage(from: error))
            }
        }
    }
    
    func showAllResults() {
        state = .loadedList(allResults)
        isShowingAll = true
    }
    
    func insertToStore(_ item: BreweryItem) {
        do {
            try store.insert([item], timestamp: Date())
            if !history.contains(where: { $0.0.id == item.id }) {
                history.insert((item, Date()), at: 0)
            }
        } catch {
            print("Store error: \(error)")
        }
    }
    
    func loadHistory() {
        do {
            if let cached = try store.retrieve() {
                let sorted = cached.feed.map { ($0, cached.timestamp) }
                self.history = sorted.sorted { $0.1 > $1.1 }
            } else {
                self.history = []
            }
        } catch {
            print("Failed to load history from store: \(error)")
            self.history = []
        }
    }
    
    func send(event: Event) {
        switch event {
        case .onAppear:
            loadHistory()
            fetch()
        }
    }
    
    enum State {
        case loadingList
        case loadedList([BreweryItem])
        case noResults(String)
        case noQuery
        case error(String)
    }
    
    enum Event {
        case onAppear
    }
    
    private func errorMessage(from error: Error) -> String {
        if let customError = error as? RemoteBreweryItemDataLoader.LoaderError {
            switch customError {
            case .connectivity:
                return "No internet connection"
            case .invalidData:
                return "Invalid data format"
            case .invalidURL:
                return "Malformed URL"
            }
        }
        return "Something went wrong"
    }
    
    private func isValidQuery(_ query: String?) -> String? {
        guard let trimmed = query?.trimmingCharacters(in: .whitespacesAndNewlines), !trimmed.isEmpty else {
            return nil
        }
        return trimmed
    }
    
    
    private func updateState(for items: [BreweryItem]) {
        DispatchQueue.main.async {
            if items.isEmpty {
                self.state = .noResults("No breweries found for your search.")
                self.allResults = []
                self.isShowingAll = false
            } else {
                self.allResults = Array(items.prefix(10))
                self.state = .loadedList(Array(self.allResults.prefix(5)))
                self.isShowingAll = true
            }
        }
    }
    
    func select(_ item: BreweryItem) {
        selectedBrewery = item
    }
}
