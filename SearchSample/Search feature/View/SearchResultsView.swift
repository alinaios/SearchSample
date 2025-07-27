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
                            .padding(.vertical, 12)
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
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 50)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                }
                .padding(.bottom)
            }
        }
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, maxHeight: 500)
        .background(Color.backgroundSecondary)
        .cornerRadius(6)
    }
}
