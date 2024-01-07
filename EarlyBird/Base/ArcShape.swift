//
//  ArcShape.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 5/1/2024.
//

import SwiftUI

struct ArcShape: Shape {
    var startAngle: Angle
    var endAngle: Angle
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Define the center of the circle
        let center = CGPoint(x: rect.midX, y: rect.midY)
        // Define the radius based on the rect
        let radius = min(rect.width, rect.height) / 2
        
        // Create the arc
        path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        return path
    }
}



#Preview {
    ArcShape(startAngle: .degrees(0), endAngle: .degrees(180))
}
