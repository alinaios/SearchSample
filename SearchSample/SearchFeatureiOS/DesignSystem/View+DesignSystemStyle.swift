//
//  View+DesignSystemStyle.swift
//  SearchSample
//
//  Created by AH on 2025-07-27.
//

import SwiftUI

extension View {
    func applyTextStyle(_ style: DesignSystemTextStyle, color: Color, skin: TextStyleSkin = DefaultTextStyleSkin()) -> some View {
        let fontSize = skin.fontSize(for: style)
        let lineSpacing = skin.lineHeight(for: style) - fontSize
        
        return self
            .font(.custom(skin.fontName(for: style), fixedSize: fontSize))
            .kerning(skin.letterSpacing(for: style))
            .lineSpacing(lineSpacing)
            .foregroundColor(color)
    }
}
