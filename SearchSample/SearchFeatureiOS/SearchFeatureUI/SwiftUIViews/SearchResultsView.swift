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
            VStack(spacing: Spacing.smallMedium) {
                ForEach(items, id: \.id) { brewery in
                    SearchResultRowView(brewery: brewery) {
                        onSelect(brewery)
                    }
                }

                if isShowingAll {
                    showMoreButton
                }
            }
        }
        .padding(.horizontal, Spacing.large)
        .frame(maxWidth: .infinity, maxHeight: 330)
        .background(Color.backgroundSecondary)
        .cornerRadius(CornerRadius.small)
    }

    private var showMoreButton: some View {
        Button("Show more", action: onShowMore)
            .applyTextStyle(.labelMedium16, color: Color.disabledContent)
            .frame(maxWidth: .infinity)
            .frame(height: 44)
            .background(Color.clear)
            .overlay(
                RoundedRectangle(cornerRadius: CornerRadius.full)
                    .stroke(Color.innerAlignment, lineWidth: 1)
            )
            .padding(.bottom)
    }
}

private struct SearchResultRowView: View {
    let brewery: BreweryItem
    let onSelect: () -> Void

    var body: some View {
        Button(action: onSelect) {
            HStack {
                Text(brewery.formattedLocation)
                    .applyTextStyle(.subtitleSemiBold16, color: Color.primaryContent)
                    .padding(.vertical, Spacing.medium)
                Spacer()
            }
        }
        .contentShape(Rectangle()) 
    }
}
