//
//  BreweryViewModel.swift
//  SearchSample
//
//  Created by AH on 2025-07-26.
//

import Foundation

final class BreweryViewModel: ObservableObject {
    @Published private(set) var state = State.loadingList
    private let service: BreweryItemDataLoader

    init(service: BreweryItemDataLoader) {
        self.service = service
    }

    func fetch(query: String? = nil) {
        state = .loadingList
        service.load(query: query) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let items):
                    self.state = .loadedList(items)
                case .failure(let error):
                    self.state = .error(error)
                }
            }
        }
    }

    func send(event: Event) {
        switch event {
        case .onAppear:
            fetch()
        }
    }

    enum State {
        case loadingList
        case loadedList([BreweryItem])
        case error(Error)
    }

    enum Event {
        case onAppear
    }
}
