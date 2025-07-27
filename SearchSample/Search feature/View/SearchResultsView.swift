//
//  SearchResultsView.swift
//  SearchSample
//
//  Created by AH on 2025-07-27.
//

import SwiftUI

struct SearchResultsView: View {
    let items: [BreweryItem]
    let isShowingAll: Bool
    let onSelect: (BreweryItem) -> Void
    let onShowMore: () -> Void

    var body: some View {
        ScrollView(showsIndicators: false) {
            ForEach(items, id: \.id) { brewery in
                Button {
                    onSelect(brewery)
                } label: {
                    HStack {
                        Text("\(brewery.street ?? ""), \(brewery.state ?? "")")
                            .applyTextStyle(.subtitleSemiBold16, color: Color.primaryContent)
                            .padding(.vertical, Spacing.medium)
                        Spacer()
                    }
                }
            }

            if isShowingAll {
                Button(action: {
                    onShowMore()
                }) {
                    Text("Show more")
                        .applyTextStyle(.labelMedium16, color: Color.disabledContent)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, Spacing.smallMedium)
                        .overlay(
                            RoundedRectangle(cornerRadius: CornerRadius.full)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                }
                .padding(.bottom)
            }
        }
        .padding(.horizontal, Spacing.large)
        .frame(maxWidth: .infinity, maxHeight: 268)
        .background(Color.backgroundSecondary)
        .cornerRadius(6)
    }
}
