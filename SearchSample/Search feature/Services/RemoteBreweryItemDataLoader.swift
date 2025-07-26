//
//  RemoteBreweryItemDataLoader.swift
//  SearchSample
//
//  Created by AH on 2025-07-26.
//

import Foundation

public final class RemoteBreweryItemDataLoader: BreweryItemDataLoader {
    private let url: URL
    private let client: HTTPClient
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
        case invalidURL
    }
    
    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    public func load(query: String?, completion: @escaping (SearchResult) -> Void) {
        guard let finalURL = makeURL(with: query) else {
            completion(.failure(Error.invalidURL))
            return
        }

        client.get(from: finalURL) { [weak self] response in
            guard self != nil else { return }

            switch response {
            case let .success((data, response)):
                do {
                    let items = try BreweryItemsMapper.map(data, from: response)
                    completion(.success(items))
                } catch {
                    completion(.failure(error))
                }

            case .failure:
                completion(.failure(Error.connectivity))
            }
        }
    }
    
    private func makeURL(with query: String?) -> URL? {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        var queryItems = components?.queryItems ?? []

        if let query, !query.isEmpty {
            queryItems.append(URLQueryItem(name: "query", value: query))
        }

        components?.queryItems = queryItems
        return components?.url
    }
}
