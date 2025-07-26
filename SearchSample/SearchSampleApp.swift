//
//  SearchSampleApp.swift
//  SearchSample
//
//  Created by AH on 2025-07-26.
//

import SwiftUI

let breweriesService = URL(string: "https://api.openbrewerydb.org/v1/breweries?per_page=5")!
let client = URLSessionHTTPClient(session: URLSession.shared)
let service =  RemoteBreweryItemDataLoader(url: breweriesService, client: client)

@main
struct SearchSampleApp: App {
    var body: some Scene {
        WindowGroup {
            BrewerySearchView(viewModel: BreweryViewModel(service: service))
        }
    }
}
