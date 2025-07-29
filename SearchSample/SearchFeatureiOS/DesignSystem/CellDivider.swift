//
//  CellDivider.swift
//  SearchSample
//
//  Created by AH on 2025-07-28.
//

import SwiftUI

struct CellDivider: View {
    var color: Color = Color.disabledContent.opacity(0.5)
    var height: CGFloat = 0.5
    var leadingPadding: CGFloat = 0
    var trailingPadding: CGFloat = 0
    
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(height: height)
            .padding(.leading, leadingPadding)
            .padding(.trailing, trailingPadding)
    }
}
