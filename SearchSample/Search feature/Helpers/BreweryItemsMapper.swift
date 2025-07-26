//
//  BreweryItemsMapper.swift
//  SearchSample
//
//  Created by AH on 2025-07-26.
//

import Foundation

public final class BreweryItemsMapper {
    private struct RemoteBreweryItem: Decodable {
        let id: UUID
        let name: String
        let breweryType: String
        let address1: String?
        let address2: String?
        let address3: String?
        let city: String
        let stateProvince: String?
        let postalCode: String
        let country: String
        let longitude: Double?
        let latitude: Double?
        let phone: String?
        let websiteURL: String?
        let state: String?
        let street: String?

        enum CodingKeys: String, CodingKey {
            case id
            case name
            case breweryType = "brewery_type"
            case address1 = "address_1"
            case address2 = "address_2"
            case address3 = "address_3"
            case city
            case stateProvince = "state_province"
            case postalCode = "postal_code"
            case country
            case longitude
            case latitude
            case phone
            case websiteURL = "website_url"
            case state
            case street
        }
    }

    public enum Error: Swift.Error {
        case invalidData
    }

    public static func map(_ data: Data, from response: HTTPURLResponse) throws -> [BreweryItem] {
        guard response.isOK else {
            print("❌ Invalid HTTP response code: \(response.statusCode)")
            throw Error.invalidData
        }

        do {
            let remoteItems = try JSONDecoder().decode([RemoteBreweryItem].self, from: data)
            print("✅ Successfully decoded \(remoteItems.count) brewery items.")
            
            return remoteItems.map {
                BreweryItem(
                    id: $0.id,
                    name: $0.name,
                    breweryType: $0.breweryType,
                    address1: $0.address1,
                    address2: $0.address2,
                    address3: $0.address3,
                    city: $0.city,
                    stateProvince: $0.stateProvince,
                    postalCode: $0.postalCode,
                    country: $0.country,
                    longitude: $0.longitude,
                    latitude: $0.latitude,
                    phone: $0.phone,
                    websiteURL: $0.websiteURL,
                    state: $0.state,
                    street: $0.street
                )
            }
        } catch {
            print("❌ Failed to decode BreweryItem list: \(error.localizedDescription)")
            
            if let rawJSON = String(data: data, encoding: .utf8) {
                print("🔍 Raw JSON:\n\(rawJSON)")
            } else {
                print("⚠️ Could not decode data to UTF-8 string for inspection.")
            }

            throw Error.invalidData
        }
    }

}
