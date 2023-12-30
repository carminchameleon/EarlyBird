//
//  Common.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 29/12/2023.
//

import Foundation
import SwiftUI

struct Common {
    // change hex code (from core data) to Color
    static func convertHexToColor(_ hex: String?) -> Color {
        if let hex = hex {
            return Color(UIColor(hex: hex))
        } else {
            return Color.accentColor
        }
    }
}
