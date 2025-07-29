//
//  TextStyleSkin.swift
//  SearchSample
//
//  Created by AH on 2025-07-27.
//

import Foundation

protocol TextStyleSkin {
    func fontName(for style: DesignSystemTextStyle) -> String
    func fontSize(for style: DesignSystemTextStyle) -> CGFloat
    func lineHeight(for style: DesignSystemTextStyle) -> CGFloat
    func letterSpacing(for style: DesignSystemTextStyle) -> CGFloat
}
