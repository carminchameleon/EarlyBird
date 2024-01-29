//
//  VerticalCenter.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 30/1/2024.
//

import SwiftUI

struct VerticalCenterModifier: ViewModifier {
    func body(content: Content) -> some View {
        VStack {
            Spacer()
            content
            Spacer()
        }
    }
}

#Preview {
    Circle()
        .frame(height: 30)
        .verticalCenter()
}

extension View {
    func verticalCenter() -> some View {
        self.modifier(VerticalCenterModifier())
    }
}
