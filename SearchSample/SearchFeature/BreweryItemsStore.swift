//
//  BreweryItemsStore.swift
//  SearchSample
//
//  Created by AH on 2025-07-27.
//

import Foundation

public typealias CachedFeed = (feed: [BreweryItem], timestamp: Date)

public protocol BreweryItemsStore {
    func insert(_ feed: [BreweryItem], timestamp: Date) throws
    func retrieve() throws -> CachedFeed?
}
