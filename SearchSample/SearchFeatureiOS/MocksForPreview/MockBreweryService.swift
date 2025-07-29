//
//  MockBreweryService.swift
//  SearchSample
//
//  Created by AH on 2025-07-26.
//

import Foundation

public final class MockBreweryService: BreweryItemDataLoader {
    public init() {}

    public func load(query: String?) async throws -> [BreweryItem] {
        return [
            BreweryItem(
                id: UUID(),
                name: "Mock Brewing Co.",
                breweryType: "micro",
                city: "Mockville",
                postalCode: "12345",
                country: "Mockland"
            ),
            BreweryItem(
                id: UUID(),
                name: "Test Brewery",
                breweryType: "regional",
                city: "Test City",
                postalCode: "67890",
                country: "Testonia"
            )
        ]
    }
}
