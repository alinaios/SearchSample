//
//  BreweryItem.swift
//  SearchSample
//
//  Created by AH on 2025-07-26.
//

import Foundation

public struct BreweryItem: Hashable {
    public let id: String
    public let name: String
    public let breweryType: String
    public let address1: String?
    public let address2: String?
    public let address3: String?
    public let city: String
    public let stateProvince: String?
    public let postalCode: String
    public let country: String
    public let longitude: Double?
    public let latitude: Double?
    public let phone: String?
    public let websiteURL: String?
    public let state: String?
    public let street: String?
}
