//
//  DetailsView.swift
//  SearchSample
//
//  Created by AH on 2025-07-28.
//

import SwiftUI

struct DetailsView: View {
    @Environment(\.presentationMode) private var presentationMode
    let item: BreweryItem

    var body: some View {
        VStack(spacing: Spacing.large) {
            // Top Slider/Icon
            Image(.sliderIcon)
                .resizable()
                .scaledToFit()
                .frame(height: 10)
                .padding(.top, 48)

            // Title
            titleView
                .padding(.horizontal, Spacing.large)

            // Address Section
            VStack(alignment: .leading, spacing: Spacing.smallMedium) {
                Text("Address")
                    .applyTextStyle(.headlineBold16, color: .primaryContent)
                Text(item.formattedLocation)
                    .applyTextStyle(.bodyRegular16, color: .primaryContent)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, Spacing.large)

            Spacer()

            // Back Button
            actionButtonView
                .padding(.horizontal, Spacing.large)
                .padding(.bottom, Spacing.large)
        }
        .background(Color.backgroundPrimary.ignoresSafeArea())
        .modifier(NavigationBarModifier(showBackButton: true))
    }

    private var titleView: some View {
        Text(item.name)
            .applyTextStyle(.titleLarge, color: .primaryContent)
            .multilineTextAlignment(.center)
            .padding(.top, Spacing.medium)
    }

    private var actionButtonView: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Text("Back")
                .applyTextStyle(.headlineBold16, color: .primaryContent)
                .frame(maxWidth: .infinity, minHeight: 44)
                .background(Color.backgroundAccent)
                .cornerRadius(CornerRadius.full)
        }
    }
}
