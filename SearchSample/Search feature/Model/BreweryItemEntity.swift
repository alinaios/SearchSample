//
//  BreweryItemEntity.swift
//  SearchSample
//
//  Created by AH on 2025-07-26.
//

import SwiftData
import Foundation

@Model
public class BreweryItemEntity: IdentifiableEntity {
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
    public var timestamp: Date?

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
        street: String? = nil,
        timestamp: Date? = nil
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
        self.timestamp = timestamp
    }
}
extension BreweryItemEntity {
    func toModel() -> BreweryItem {
        BreweryItem(
            id: self.id,
            name: self.name,
            breweryType: self.breweryType,
            address1: self.address1,
            address2: self.address2,
            address3: self.address3,
            city: self.city,
            stateProvince: self.stateProvince,
            postalCode: self.postalCode,
            country: self.country,
            longitude: self.longitude,
            latitude: self.latitude,
            phone: self.phone,
            websiteURL: self.websiteURL,
            state: self.state,
            street: self.street
        )
    }
}
protocol IdentifiableEntity {
    var id: UUID { get }
}
