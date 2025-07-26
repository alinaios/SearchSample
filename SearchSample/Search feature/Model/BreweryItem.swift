//
//  BreweryItem.swift
//  SearchSample
//
//  Created by AH on 2025-07-26.
//

import Foundation

public struct BreweryItem: Hashable {
    public let id: UUID
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

    public init(
        id: UUID,
        name: String,
        breweryType: String,
        address1: String? = nil,
        address2: String? = nil,
        address3: String? = nil,
        city: String,
        stateProvince: String? = nil,
        postalCode: String,
        country: String,
        longitude: Double? = nil,
        latitude: Double? = nil,
        phone: String? = nil,
        websiteURL: String? = nil,
        state: String? = nil,
        street: String? = nil
    ) {
        self.id = id
        self.name = name
        self.breweryType = breweryType
        self.address1 = address1
        self.address2 = address2
        self.address3 = address3
        self.city = city
        self.stateProvince = stateProvince
        self.postalCode = postalCode
        self.country = country
        self.longitude = longitude
        self.latitude = latitude
        self.phone = phone
        self.websiteURL = websiteURL
        self.state = state
        self.street = street
    }
}
