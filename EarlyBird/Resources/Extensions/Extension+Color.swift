//
//  Extension+Color.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 30/12/2023.
//

import SwiftUI

extension Color {
    static let theme = ColorTheme()
}


struct ColorTheme {
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let secondaryText = Color("SecondaryTextColor")
    let detailBackground = Color("detailBackground")
    let pill = Color("pill")
    let text = Color("text")
    let detailText = Color("detailText")
    let subText = Color("subText")
}
