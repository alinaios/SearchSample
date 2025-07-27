//
//  SearchBarView.swift
//  SearchSample
//
//  Created by AH on 2025-07-27.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var query: String
    var onSubmit: () -> Void
    
    var body: some View {
        ZStack(alignment: .leading) {
            if query.isEmpty {
                Text("Search...")
                    .applyTextStyle(.subtitleSemiBold16, color: Color.disabledContent)
                    .padding(.horizontal, Spacing.large)
            }
            
            TextField("", text: $query)
                .padding(.vertical, Spacing.medium)
                .padding(.horizontal, Spacing.large)
                .applyTextStyle(.subtitleSemiBold16, color: Color.primaryContent)
                .frame(height: 50)
                .cornerRadius(CornerRadius.small)
                .overlay(
                    RoundedRectangle(cornerRadius: CornerRadius.small)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .opacity(1)
                .onSubmit {
                    onSubmit()
                }
        }
    }
}
