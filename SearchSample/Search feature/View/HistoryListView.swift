//
//  HistoryListView.swift
//  SearchSample
//
//  Created by AH on 2025-07-27.
//


import SwiftUI

struct HistoryListView: View {
    let history: [(BreweryItem, Date)]

    var body: some View {
        if history.isEmpty { return AnyView(EmptyView()) }

        return AnyView(
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: Spacing.medium) {
                    Text("History")
                        .applyTextStyle(.headlineBold16, color: Color.primaryContent)

                    ForEach(history.prefix(5), id: \.0.id) { (brewery, date) in
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
            }
        )
    }
}
