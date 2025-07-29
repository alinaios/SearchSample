//
//  HTTPClient.swift
//  SearchSample
//
//  Created by AH on 2025-07-26.
//

import Foundation

public protocol HTTPClient {
    func get(from url: URL) async throws -> (Data, HTTPURLResponse)
}
