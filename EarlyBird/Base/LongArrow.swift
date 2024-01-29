//
//  LongArrow.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 28/1/2024.
//

import SwiftUI


struct LongArrow: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        // Starting point at the left middle
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))

        // Draw line to right middle
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))

        // Draw the arrow head
        let headWidth = rect.height * 2 // adjust the size of the arrow head
        let headHeight = rect.height * 2 // adjust the size of the arrow head
        path.move(to: CGPoint(x: rect.maxX - headHeight, y: rect.midY - headWidth / 2))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX - headHeight, y: rect.midY + headWidth / 2))

        return path
    }
}


#Preview {
    LongArrow()
}
