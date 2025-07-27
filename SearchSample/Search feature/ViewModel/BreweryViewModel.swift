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
    
    private let service: BreweryItemDataLoader
    private let store: BreweryItemsStore
    private var allResults: [BreweryItem] = []
    private(set) var isShowingAll = false

    init(service: BreweryItemDataLoader, store: BreweryItemsStore) {
        self.service = service
        self.store = store
    }

    func fetch(query: String? = nil) {
        guard let query = query, !query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            DispatchQueue.main.async {
                self.state = .loadedList(nil)
                self.allResults = []
                self.isShowingAll = false
            }
            return
        }
        state = .loadingList
        service.load(query: query) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let items):
                    self.allResults = Array(items.prefix(10))
                    self.state = .loadedList(Array(self.allResults.prefix(5)))
                    self.isShowingAll = true
                case .failure(let error):
                    self.state = .error(error)
                }
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
            print("⚠️ Store error: \(error)")
        }
    }
    
    func loadHistory() {
        do {
            if let cached = try store.retrieve() {
                // Sort history by timestamp descending (most recent first)
                let sorted = cached.feed.map { ($0, cached.timestamp) }
                self.history = sorted.sorted { $0.1 > $1.1 }
            } else {
                self.history = []
            }
        } catch {
            print("⚠️ Failed to load history from store: \(error)")
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
        case loadedList([BreweryItem]?)
        case error(Error)
    }

    enum Event {
        case onAppear
    }
}
