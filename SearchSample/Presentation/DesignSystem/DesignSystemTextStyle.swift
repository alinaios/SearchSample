//
//  DesignSystemTextStyle.swift
//  SearchSample
//
//  Created by AH on 2025-07-27.
//

import SwiftUI

enum DesignSystemTextStyle: CaseIterable {
    case titleLarge          // 1
    case titleMedium         // 2
    case headlineBold16      // 3
    case bodyRegular16       // 4 & 10 (merged - identical)
    case bodyRegular13       // 5
    case subtitleSemiBold16  // 6 (same as 2, but kept for clarity)
    case labelMedium16       // 7
    case captionSemiBold14   // 8
    case captionBold14       // 9
}
