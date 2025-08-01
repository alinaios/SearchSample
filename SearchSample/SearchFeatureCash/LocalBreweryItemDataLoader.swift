//
//  LocalBreweryItemDataLoader.swift
//  SearchSample
//
//  Created by AH on 2025-07-26.
//

import SwiftData

public final class LocalBreweryItemDataLoader: BreweryItemDataLoader {    
    private let context: ModelContext

    public init(context: ModelContext) {
        self.context = context
    }

    public func load(query: String?) async throws -> [BreweryItem] {
        let entities = try context.fetch(FetchDescriptor<BreweryItemEntity>())
        
        return entities.map { entity in
            BreweryItem(
                id: entity.id,
                name: entity.name,
                breweryType: entity.breweryType,
                city: entity.city,
                postalCode: entity.postalCode,
                country: entity.country
            )
        }
    }
}
