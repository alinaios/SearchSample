//
//  MockBreweryItemsStore.swift
//  SearchSample
//
//  Created by AH on 2025-07-27.
//
    
import Foundation

public final class MockBreweryItemsStore: BreweryItemsStore {
    private var cache: CachedFeed?

    public init(cachedFeed: CachedFeed? = nil) {
        self.cache = cachedFeed
    }

    public func deleteCachedFeed() throws {
        cache = nil
    }

    public func insert(_ feed: [BreweryItem], timestamp: Date) throws {
        cache = (feed: feed, timestamp: timestamp)
    }

    public func retrieve() throws -> CachedFeed? {
        return cache
    }
}
