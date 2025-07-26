//
//  BreweryItemEntity.swift
//  SearchSample
//
//  Created by AH on 2025-07-26.
//

import SwiftData
import Foundation

@Model
public class BreweryItemEntity {
    @Attribute(.unique) public var id: UUID
    public var name: String
    public var breweryType: String

    public var address1: String?
    public var address2: String?
    public var address3: String?
    public var city: String
    public var stateProvince: String?
    public var postalCode: String
    public var country: String
    public var longitude: Double?
    public var latitude: Double?
    public var phone: String?
    public var websiteURL: String?
    public var state: String?
    public var street: String?

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
