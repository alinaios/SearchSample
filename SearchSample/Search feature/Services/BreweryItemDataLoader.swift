//
//  BreweryItemDataLoader.swift
//  SearchSample
//
//  Created by AH on 2025-07-26.
//

import Foundation

public protocol BreweryItemDataLoader {
    typealias SearchResult = Result<[BreweryItem], Error>
    
    func load(query: String?, completion: @escaping (SearchResult) -> Void)
}
