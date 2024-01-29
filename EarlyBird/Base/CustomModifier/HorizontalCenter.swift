//
//  HorizontalCenter.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 30/1/2024.
//

import SwiftUI

struct HorizontalCenter: ViewModifier {
    func body(content: Content) -> some View {
        HStack {
            Spacer()
            content
            Spacer()
        }
    }
}

#Preview {
    HStack {
        Circle()
            .frame(height: 30)
        Circle()
            .frame(height: 30)
        Circle()
            .frame(height: 30)
    }
        .centeredHorizontally()
}

extension View {
    func centeredHorizontally() -> some View {
        self.modifier(HorizontalCenter())
    }
}
