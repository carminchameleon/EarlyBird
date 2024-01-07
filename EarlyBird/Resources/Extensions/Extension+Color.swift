//
//  Extension+Color.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 30/12/2023.
//

import SwiftUI

extension Color {
    
    func toUIColor() -> UIColor {
            if #available(iOS 14.0, *) {
                return UIColor(self)
            } else {
                let components = UIColor(self).cgColor.components!
                return UIColor(red: components[0], green: components[1], blue: components[2], alpha: components[3])
            }
    }
}
