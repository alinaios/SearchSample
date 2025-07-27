//
//  BrewerySearchView.swift
//  SearchSample
//
//  Created by AH on 2025-07-26.
//

import SwiftUI

struct BrewerySearchView: View {
    @ObservedObject var viewModel: BreweryViewModel
    @State private var query: String = ""

    var body: some View {
        VStack(spacing: 24) {
            // Icon
            Image(systemName: "magnifyingglass.circle.fill")
                .resizable()
                .frame(width: 80, height: 80)
                .foregroundColor(.accentColor)
                .padding(.top, 40)

            // Title
            Text("Search for a brewery")
                .font(.title)
                .bold()

            // Search field
            TextField("Enter brewery name...", text: $query)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)
                .onSubmit {
                    viewModel.fetch()
                }

            // Results
            contentView
        }
        .onAppear {
            viewModel.send(event: .onAppear)
        }
    }

    @ViewBuilder
    private var contentView: some View {
        switch viewModel.state {
        case .loadingList:
            ProgressView("Loading breweries...")
                .padding(.top)

        case .loadedList(let items):
            if items.isEmpty {
                Text("No results found")
                    .foregroundColor(.secondary)
                    .padding(.top)
            } else {
                List(items, id: \.id) { brewery in
                    VStack(alignment: .leading) {
                        Text(brewery.name)
                            .font(.headline)
                        Text("\(brewery.city), \(brewery.state ?? "")")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                .listStyle(.plain)
            }

        case .error:
            Text("Something went wrong. Please try again.")
                .foregroundColor(.red)
                .padding()
        }
    }
}
#Preview {
    BrewerySearchView(viewModel: .init(service: MockBreweryService(), store: MockBreweryItemsStore()))
}

