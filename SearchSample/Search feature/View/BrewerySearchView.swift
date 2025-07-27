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
            headerView
            VStack(alignment: .leading, spacing: Spacing.medium) {
                SearchBarView(query: $query) {
                    viewModel.fetch(query: query)
                }
                contentView
                HistoryListView(history: viewModel.history)
                    .padding(.top, 41)
            }
            .padding(.horizontal)
            Spacer()
        }
        .background(Color.backgroundPrimary)
        .onAppear {
            viewModel.send(event: .onAppear)
        }
    }
    
    private var headerView: some View {
        VStack(spacing: Spacing.medium) {
            Image(.searchIcon)
                .frame(width: 197)
                .padding(.top, 94)
                .padding(.bottom, 26)

            Image(.sliderIcon)
                .frame(height: 10)
                .padding(.bottom, 32)

            Text("Search for a brewery")
                .applyTextStyle(.titleLarge, color: Color.primaryContent)
        }
    }
    
    @ViewBuilder
    private var contentView: some View {
        switch viewModel.state {
        case .loadingList:
            ProgressView("Loading...")
                .padding(.top)

        case .loadedList(let items):
            if items.isEmpty && query.isEmpty {
                EmptyView()
            } else if items.isEmpty {
                Text("No results found")
                    .foregroundColor(.secondary)
                    .padding(.top)
            } else {
                SearchResultsView(
                    items: items,
                    isShowingAll: viewModel.isShowingAll,
                    onSelect: { viewModel.insertToStore($0) },
                    onShowMore: { viewModel.showAllResults() }
                )
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

