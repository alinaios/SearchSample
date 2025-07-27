//
//  SwiftDataBreweryItemsStore.swift
//  SearchSample
//
//  Created by AH on 2025-07-27.
//

import Foundation
import SwiftData

public final class SwiftDataBreweryItemsStore: BreweryItemsStore {
    private let context: ModelContext

    public init(context: ModelContext) {
        self.context = context
    }

    public func deleteCachedFeed() throws {
        try deleteAll(BreweryItemEntity.self)
    }

    public func insert(_ feed: [BreweryItem], timestamp: Date) throws {
        try deleteCachedFeed()

        for item in feed {
            let entity = BreweryItemEntity(
                id: item.id,
                name: item.name,
                breweryType: item.breweryType,
                address1: item.address1,
                address2: item.address2,
                address3: item.address3,
                city: item.city,
                stateProvince: item.stateProvince,
                postalCode: item.postalCode,
                country: item.country,
                longitude: item.longitude,
                latitude: item.latitude,
                phone: item.phone,
                websiteURL: item.websiteURL,
                state: item.state,
                street: item.street,
                timestamp: timestamp
            )
            context.insert(entity)
        }

        try context.save()
    }

    public func retrieve() throws -> CachedFeed? {
        let descriptor = FetchDescriptor<BreweryItemEntity>(
            sortBy: [SortDescriptor(\.timestamp, order: .reverse)]
        )

        let items = try context.fetch(descriptor)

        // Deduplicate by ID, keeping only the latest entry per ID
        var seen = Set<UUID>()
        let uniqueItems = items.filter { item in
            guard !seen.contains(item.id) else { return false }
            seen.insert(item.id)
            return true
        }

        return CachedFeed(
            feed: uniqueItems.map { $0.toModel() },
            timestamp: uniqueItems.first?.timestamp ?? .distantPast
        )
    }

    // MARK: - Helpers

    private func deleteAll<T: PersistentModel>(_ type: T.Type) throws {
        let items = try context.fetch(FetchDescriptor<T>())
        for item in items {
            context.delete(item)
        }
    }
}
