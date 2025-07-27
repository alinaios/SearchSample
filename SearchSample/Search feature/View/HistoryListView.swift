//
//  HistoryListView.swift
//  SearchSample
//
//  Created by AH on 2025-07-27.
//


import SwiftUI

struct HistoryListView: View {
    let history: [(BreweryItem, Date)]
    
    @ViewBuilder
    var body: some View {
        if history.isEmpty {
            EmptyView()
        } else {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: Spacing.medium) {
                    Text("History")
                        .applyTextStyle(.headlineBold16, color: Color.primaryContent)
                    
                    ForEach(history, id: \.0.id) { brewery, date in
                        HistoryItemView(brewery: brewery, date: date)
                    }
                }
            }
        }
    }
}

private struct HistoryItemView: View {
    let brewery: BreweryItem
    let date: Date
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: Spacing.small) {
                Text(brewery.name)
                    .applyTextStyle(.bodyRegular16, color: Color.primaryContent)
                Text(date.formatted(date: .numeric, time: .shortened))
                    .applyTextStyle(.bodyRegular13, color: Color.secondaryContent)
            }
            Spacer()
        }
    }
}
