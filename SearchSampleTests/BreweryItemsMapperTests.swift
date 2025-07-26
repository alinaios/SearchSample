//
//  BreweryItemsMapperTests.swift
//  SearchSampleTests
//
//  Created by AH on 2025-07-26.
//

import SearchSample
import XCTest
import Foundation

class BreweryItemsMapperTests: XCTestCase {
    
    func test_map_throwsErrorOnNon200HTTPResponse() throws {
        let json = makeItemsJSON([])
        let samples = [199, 201, 300, 400, 500]
        
        try samples.forEach { code in
            XCTAssertThrowsError(
                try BreweryItemsMapper.map(json, from: HTTPURLResponse(statusCode: code))
            )
        }
    }
    
    func test_map_throwsErrorOn200HTTPResponseWithInvalidJSON() {
        let invalidJSON = Data("invalid json".utf8)
        
        XCTAssertThrowsError(
            try BreweryItemsMapper.map(invalidJSON, from: HTTPURLResponse(statusCode: 200))
        )
    }
    
    func test_map_deliversNoItemsOn200HTTPResponseWithEmptyJSONList() throws {
        let emptyListJSON = makeItemsJSON([])
        
        let result = try BreweryItemsMapper.map(emptyListJSON, from: HTTPURLResponse(statusCode: 200))
        
        XCTAssertEqual(result, [])
    }
    
    func test_map_deliversItemsOn200HTTPResponseWithJSONItems() throws {
        let item1 = makeItem(
            id: UUID(),
            name: "Brewery One",
            breweryType: "micro",
            city: "City A",
            postalCode: "12345",
            country: "Country A"
        )
        
        let item2 = makeItem(
            id: UUID(),
            name: "Brewery Two",
            breweryType: "regional",
            city: "City B",
            postalCode: "67890",
            country: "Country B"
        )
        
        let json = makeItemsJSON([item1.json, item2.json])
        
        let result = try BreweryItemsMapper.map(json, from: HTTPURLResponse(statusCode: 200))
        
        XCTAssertEqual(result, [item1.model, item2.model])
    }
    
    // MARK: - Helpers
    
    private func makeItem(
        id: UUID,
        name: String,
        breweryType: String,
        city: String,
        postalCode: String,
        country: String) -> (model: BreweryItem, json: [String: Any]) {
        
        let item = BreweryItem(
            id: id,
            name: name,
            breweryType: breweryType,
            city: city,
            postalCode: postalCode,
            country: country)
        
        let json : [String: Any] = [
            "id": id.uuidString,
            "name": name,
            "brewery_type": breweryType,
            "city": city,
            "postal_code": postalCode,
            "country": country]
        .compactMapValues { $0 }
        
        return (item, json)
    }
}
