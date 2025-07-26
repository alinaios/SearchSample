//
//  HTTPClient.swift
//  SearchSample
//
//  Created by AH on 2025-07-26.
//

import Foundation

public protocol HTTPClient {
    typealias Result = Swift.Result<(Data, HTTPURLResponse), Error>
    
    func get(from url: URL, completion: @escaping (Result) -> Void)
}
