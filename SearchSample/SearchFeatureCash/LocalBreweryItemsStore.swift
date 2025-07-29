//
//  LocalBreweryItemsStore.swift
//  SearchSample
//
//  Created by AH on 2025-07-27.
//

import Foundation
import SwiftData

public final class LocalBreweryItemsStore: BreweryItemsStore {
    private let context: ModelContext

    public init(context: ModelContext) {
        self.context = context
    }

    public func insert(_ feed: [BreweryItem], timestamp: Date) throws {
        // Optional: fetch existing items to avoid duplicates
        let existing = try retrieve()?.feed ?? []
        let existingIDs = Set(existing.map { $0.id })

        for item in feed where !existingIDs.contains(item.id) {
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
}
