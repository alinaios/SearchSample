//
//  NavigationBarModifier.swift
//  SearchSample
//
//  Created by AH on 2025-07-28.
//

import SwiftUI

struct NavigationBarModifier: ViewModifier {
    @Environment(\.dismiss) private var dismiss
    var showBackButton: Bool = true
    var color: Color = Color.clear
    var textColor: Color = Color.primaryContent
    var onBack: (() -> Void)? = nil
    
    func body(content: Content) -> some View {
        ZStack {
            color.edgesIgnoringSafeArea(.all)
            content
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(leading: backButton)
    }
    
    private var backButton: some View {
        Button(action: {
            if let onBack = onBack {
                onBack()
            } else {
                dismiss()
            }
        }) {
            HStack(spacing: Spacing.small) {
                if showBackButton {
                    Image(systemName: "chevron.left")
                        .renderingMode(.template)
                        .foregroundColor(textColor)
                    Text("BACK")
                        .applyTextStyle(.bodyRegular16, color: textColor)
                }
            }
        }
    }
}
