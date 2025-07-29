//
//  BreweryViewModel.swift
//  SearchSample
//
//  Created by AH on 2025-07-26.
//

import Foundation

@MainActor
public final class BreweryViewModel: ObservableObject {
    // MARK: - Published Properties

    @Published private(set) var state = State.loadingList
    @Published var history: [(BreweryItem, Date)] = []
    @Published var selectedBrewery: BreweryItem?

    // MARK: - Private Properties

    private let service: BreweryItemDataLoader
    private let store: BreweryItemsStore
    private var allResults: [BreweryItem] = []
    private(set) var isShowingAll = false

    // MARK: - Initialization

    public init(service: BreweryItemDataLoader, store: BreweryItemsStore) {
        self.service = service
        self.store = store
    }

    // MARK: - Public API

    public func fetch(query: String? = nil) async {
        guard let validatedQuery = isValidQuery(query) else {
            state = .noQuery
            allResults = []
            isShowingAll = false
            return
        }

        state = .loadingList

        do {
            let items = try await service.load(query: validatedQuery)
            updateState(for: items)
        } catch {
            state = .error(errorMessage(from: error))
        }
    }

    public func showAllResults() {
        state = .loadedList(allResults)
        isShowingAll = true
    }

    public func insertToStore(_ item: BreweryItem) {
        do {
            try store.insert([item], timestamp: Date())
            if !history.contains(where: { $0.0.id == item.id }) {
                history.insert((item, Date()), at: 0)
            }
        } catch {
            print("Store error: \(error)")
        }
    }

    public func loadHistory() async {
        do {
            if let cached = try store.retrieve() {
                let entries = cached.feed.map { ($0, cached.timestamp) }
                history = entries.sorted { $0.1 > $1.1 }
            } else {
                history = []
            }
        } catch {
            print("Failed to load history from store: \(error)")
            history = []
        }
    }

    public func send(event: Event) async {
        switch event {
        case .onAppear:
            await loadHistory()
            await fetch()
        }
    }

    public func select(_ item: BreweryItem) {
        selectedBrewery = item
    }

    // MARK: - Internal State Management

    private func updateState(for items: [BreweryItem]) {
        if items.isEmpty {
            state = .noResults("No breweries found for your search.")
            allResults = []
            isShowingAll = false
        } else {
            allResults = Array(items.prefix(10))
            state = .loadedList(Array(allResults.prefix(5)))
            isShowingAll = true
        }
    }

    private func isValidQuery(_ query: String?) -> String? {
        guard let trimmed = query?.trimmingCharacters(in: .whitespacesAndNewlines), !trimmed.isEmpty else {
            return nil
        }
        return trimmed
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

    // MARK: - State & Events

    public enum State {
        case loadingList
        case loadedList([BreweryItem])
        case noResults(String)
        case noQuery
        case error(String)
    }

    public enum Event {
        case onAppear
    }
}
