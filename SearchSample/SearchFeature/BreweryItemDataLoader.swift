//
//  BreweryItemDataLoader.swift
//  SearchSample
//
//  Created by AH on 2025-07-26.
//

import Foundation

public protocol BreweryItemDataLoader {
    func load(query: String?) async throws -> [BreweryItem]
}
