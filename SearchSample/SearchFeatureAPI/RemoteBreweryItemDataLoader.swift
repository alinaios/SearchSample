//
//  RemoteBreweryItemDataLoader.swift
//  SearchSample
//
//  Created by AH on 2025-07-26.
//

import Foundation

public final class RemoteBreweryItemDataLoader: BreweryItemDataLoader {
    public enum LoaderError: Swift.Error {
        case connectivity
        case invalidData
        case invalidURL
    }

    private let baseURL: URL
    private let client: HTTPClient

    public init(url: URL, client: HTTPClient) {
        self.baseURL = url
        self.client = client
    }
    
    public func load(query: String?) async throws -> [BreweryItem] {
        guard let finalURL = makeURL(with: query) else {
            throw LoaderError.invalidURL
        }

        do {
            let (data, response) = try await client.get(from: finalURL)
            return try BreweryItemsMapper.map(data, from: response)
        } catch is BreweryItemsMapper.Error {
            throw LoaderError.invalidData
        } catch {
            throw LoaderError.connectivity
        }
    }

    
    private func makeURL(with query: String?) -> URL? {
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)
        var queryItems = components?.queryItems ?? []

        if let query, !query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            queryItems.append(URLQueryItem(name: "query", value: query))
        }

        components?.queryItems = queryItems
        return components?.url
    }
}
