//
//  SearchSampleApp.swift
//  SearchSample
//
//  Created by AH on 2025-07-26.
//

import SwiftUI
import SwiftData

@main
struct SearchSampleApp: App {
    private let container: ModelContainer
    private let context: ModelContext
    private let service: BreweryItemDataLoader
    private let store: BreweryItemsStore

    init() {
        // 1. Setup SwiftData container and context
        let schema = Schema([BreweryItemEntity.self])
        container = try! ModelContainer(for: schema, configurations: [])
        context = ModelContext(container)

        // 2. Setup network client
        guard let url = URL(string: "https://api.openbrewerydb.org/v1/breweries/search?query") else {
            fatalError("Invalid Brewery API URL")
        }

        let client = URLSessionHTTPClient(session: .shared)
        self.service = RemoteBreweryItemDataLoader(url: url, client: client)
        self.store = LocalBreweryItemsStore(context: context)
    }

    var body: some Scene {
        WindowGroup {
            BrewerySearchView(
                viewModel: BreweryViewModel(service: service, store: store)
            )
        }
    }
}
