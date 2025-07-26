//
//  BreweryItemDataLoader.swift
//  SearchSample
//
//  Created by AH on 2025-07-26.
//

import Foundation

public protocol BreweryItemDataLoader {
    typealias SearchResult = Swift.Result<[BreweryItem], Error>
   
    func load(completion: @escaping (SearchResult) -> Void)
}
