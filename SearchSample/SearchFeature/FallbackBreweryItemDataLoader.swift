//
//  FallbackBreweryItemDataLoader.swift
//  SearchSample
//
//  Created by AH on 2025-07-29.
//

import Foundation

class FallbackBreweryItemDataLoader: BreweryItemDataLoader {
    let remote: BreweryItemDataLoader
    let local: BreweryItemsStore
    
    init(remote: BreweryItemDataLoader, local: BreweryItemsStore) {
        self.remote = remote
        self.local = local
    }
    
    func load(query: String?) async throws -> [BreweryItem] {
        do {
            let results = try await remote.load(query: query)
            return results
        } catch {
            print("Remote fetch failed: \(error.localizedDescription), falling back to local store.")
            return try local.retrieve()?.feed ?? []
        }
    }
}
