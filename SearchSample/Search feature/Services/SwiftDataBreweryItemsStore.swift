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
        
        // Save brewery items
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
                street: item.street
            )
            context.insert(entity)
        }
        
        // Save timestamp
        context.insert(CachedFeedMetadata(timestamp: timestamp))
        try context.save()
    }
    
    public func retrieve() throws -> CachedFeed? {
        let items = try context.fetch(FetchDescriptor<BreweryItemEntity>())
        guard !items.isEmpty else { return nil }
        
        let metadata = try context.fetch(FetchDescriptor<CachedFeedMetadata>()).first
        return CachedFeed(
            feed: items.map { $0.toModel() },
            timestamp: metadata?.timestamp ?? .distantPast
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

@Model
final class CachedFeedMetadata {
    @Attribute(.unique) var key: String
    var timestamp: Date

    init(key: String = "feed", timestamp: Date) {
        self.key = key
        self.timestamp = timestamp
    }
}
