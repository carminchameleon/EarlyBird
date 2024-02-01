//
//  CustomNavigation.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 30/1/2024.
//

import Foundation
import SwiftUI

func getCustomNavigation() -> UINavigationBarAppearance {
    let appear = UINavigationBarAppearance()
    let atters: [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: 32, weight: .black)
    ]
    appear.configureWithTransparentBackground()
    appear.largeTitleTextAttributes = atters
    
    return appear
}
