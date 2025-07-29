//
//  DefaultTextStyleSkin.swift
//  SearchSample
//
//  Created by AH on 2025-07-27.
//

import Foundation

struct DefaultTextStyleSkin: TextStyleSkin {
    func fontName(for style: DesignSystemTextStyle) -> String {
        switch style {
        case .titleLarge, .titleMedium, .subtitleSemiBold16:
            return "Poppins-SemiBold"
        case .headlineBold16, .captionBold14:
            return "Poppins-Bold"
        case .labelMedium16:
            return "Poppins-Medium"
        case .bodyRegular16, .bodyRegular13, .captionSemiBold14:
            return "Poppins-Regular"
        }
    }
    
    func fontSize(for style: DesignSystemTextStyle) -> CGFloat {
        switch style {
        case .titleLarge: return 24
        case .titleMedium, .headlineBold16, .bodyRegular16, .subtitleSemiBold16, .labelMedium16: return 16
        case .bodyRegular13: return 13
        case .captionSemiBold14, .captionBold14: return 14
        }
    }
    
    func lineHeight(for style: DesignSystemTextStyle) -> CGFloat {
        switch style {
        case .titleLarge, .titleMedium, .subtitleSemiBold16:
            return 41
        case .labelMedium16:
            return 24
        default:
            return 22
        }
    }
    
    func letterSpacing(for style: DesignSystemTextStyle) -> CGFloat {
        return 0 
    }
}
