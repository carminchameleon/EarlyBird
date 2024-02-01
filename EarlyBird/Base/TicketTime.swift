//
//  TicketTime.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 1/2/2024.
//

import SwiftUI

struct TicketTime: View {
    var label: String
    var timeLabel: String
    var size: CGFloat
    
    var dayLabel: String {
        let day = String(timeLabel.suffix(2))
        return day
    }
    
    var time: String {
        let time = String(timeLabel.prefix(5))
        return time
    }
    
    var body: some View {
        VStack(spacing: .smallSize) {
            VStack(alignment: .trailing, spacing: 0) {
                Text(dayLabel)
                    .font(.system(size: 9))
                Text(time)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
                    .font(.system(size: 32, weight: .bold, design: .rounded))
            }
            .foregroundStyle(.black)
            Text(label)
                .font(.system(size: 11, design: .default))
                .lineLimit(1)
                .minimumScaleFactor(0.8)
                .foregroundStyle(Color.accentColor)
                .padding(.vertical, 6)
                .background(RoundedRectangle(cornerRadius: 8)
                    .fill(Color.accentColor).opacity(0.1)
                    .frame(width: size)
                )
        }.frame(maxWidth: size)
    }
}

#Preview {
    TicketTime(label: "", timeLabel: "", size: 20)
}
