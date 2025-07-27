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
            VStack(alignment: .leading) {
                searchBarView
                contentView
                
                historyView
                
            }.padding()
        }
        .onAppear {
            viewModel.send(event: .onAppear)
        }
    }
    
    private var headerView: some View {
        VStack {
            Image(systemName: "magnifyingglass.circle.fill")
                .resizable()
                .frame(width: 80, height: 80)
                .foregroundColor(.accentColor)
                .padding(.top, 40)
            
            Text("Search for a brewery")
                .font(.title)
                .bold()
        }
    }
    
    private var searchBarView: some View {
        TextField("Enter brewery name...", text: $query)
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding(.horizontal)
            .onSubmit {
                viewModel.fetch(query: query)
            }
    }
    
    private var historyView: some View {
        if viewModel.history.isEmpty { return AnyView(EmptyView()) }
        
        return AnyView(
            VStack(alignment: .leading, spacing: 8) {
                Text("Search History")
                    .font(.headline)
                    .padding(.horizontal)
                
                ForEach(viewModel.history.prefix(5), id: \.0.id) { (brewery, date) in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(brewery.name)
                                .font(.subheadline)
                            Text(date.formatted(date: .numeric, time: .shortened))
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                }
            }
        )
    }
    
    private func searchResultView(items: [BreweryItem]) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                
                ForEach(items, id: \.id) { brewery in
                    VStack(alignment: .leading) {
                        Text(brewery.name)
                            .font(.headline)
                        Text("\(brewery.city), \(brewery.state ?? "")")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        viewModel.insertToStore(brewery)
                    }
                }
                .frame(maxHeight: 300)
                
                if !viewModel.isShowingAll {
                    Button("Show All Results") {
                        viewModel.showAllResults()
                    }
                    .padding(.bottom)
                }
            }
        }
    }
    
    @ViewBuilder
    private var contentView: some View {
        switch viewModel.state {
        case .loadingList:
            ProgressView("Loading breweries...")
                .padding(.top)
            
        case .loadedList(let items):
            if let items = items {
                if items.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 40))
                            .foregroundColor(.gray)
                        
                        Text("No results found")
                            .foregroundColor(.secondary)
                    }
                    .padding(.top, 60)
                } else {
                    searchResultView(items: items)
                }
            } else {
                EmptyView()
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

