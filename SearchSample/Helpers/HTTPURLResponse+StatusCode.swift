//
//  HTTPURLResponse+StatusCode.swift
//  SearchSample
//
//  Created by AH on 2025-07-26.
//

import Foundation

extension HTTPURLResponse {
    private static var OK_200: Int { return 200 }
    
    var isOK: Bool {
        return statusCode == HTTPURLResponse.OK_200
    }
}
