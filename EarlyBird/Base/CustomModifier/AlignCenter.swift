//
//  AlignCenter.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 30/1/2024.
//

import SwiftUI

struct CenterModifier: ViewModifier {
    func body(content: Content) -> some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                content
                Spacer()
            }
            Spacer()
        }
    }
}

extension View {
    func alignCenter() -> some View {
        self.modifier(CenterModifier())
    }
}
