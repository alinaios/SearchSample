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
    @State private var isNavigating = false
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 31) {
                    headerView
                    searchSection
                }
                .onAppear {
                    Task {
                        await viewModel.send(event: .onAppear)
                    }
                }
            }.background(Color.backgroundPrimary)
                .navigationDestination(isPresented: $isNavigating) {
                    if let selected = viewModel.selectedBrewery {
                        DetailsView(item: selected)
                    }
                }
        }
    }
    
    private var headerView: some View {
        VStack(spacing: Spacing.xLarge) {
            Image(.searchIcon)
                .frame(width: 197)
                .padding(.top, 94)
            
            Image(.sliderIcon)
                .frame(height: 10)
            
            Text("Search for a brewery")
                .applyTextStyle(.titleLarge, color: Color.primaryContent)
                .frame(height: 41)
        }
    }
    
    private var searchSection: some View {
        VStack(alignment: .leading, spacing: Spacing.medium) {
            SearchBarView(query: $query) {
                Task {
                    await viewModel.fetch(query: query)
                }
            }
            contentView
            
            HistoryListView(history: viewModel.history) { item in
                viewModel.select(item)
                isNavigating.toggle()
            }.padding(.top, 41)
        }
        .padding(.horizontal, Spacing.largeMedium)
    }
    
    @ViewBuilder
    private var contentView: some View {
        switch viewModel.state {
        case .loadingList:
            ProgressView()
            
        case .loadedList(let results):
            
            SearchResultsView(
                items: results,
                isShowingAll: viewModel.isShowingAll,
                onSelect: { viewModel.insertToStore($0) },
                onShowMore: { viewModel.showAllResults() }
            )
            
        case .noQuery:
            EmptyView()
            
        case .noResults(let message):
            Text(message)
                .applyTextStyle(.subtitleSemiBold16, color: Color.disabledContent)
            
        case .error(let message):
            Text(message)
                .applyTextStyle(.bodyRegular13, color: Color.red)
        }
    }
}
#Preview {
    BrewerySearchView(viewModel: .init(service: MockBreweryService(),
                                       store: MockBreweryItemsStore()))
}

