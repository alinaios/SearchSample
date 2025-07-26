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
    }
    
    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    public func load(completion: @escaping (SearchResult) -> Void) {
        client.get(from: url) { [weak self] response in
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
}
