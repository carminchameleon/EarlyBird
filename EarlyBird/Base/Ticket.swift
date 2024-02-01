//
//  Ticket.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 28/1/2024.
//

import SwiftUI

struct Ticket: View {
    @ObservedObject var habit: Habit
    var padding: CGFloat = .largeSize
    
    var width: CGFloat {
        return UIScreen.main.bounds.width - padding
    }
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                Text(habit.title)
                    .font(.system(size: 14, weight: .semibold, design: .default))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.leading, .regularSize)
            .padding(.vertical, .miniSize)
            .background(Color.accentColor)
            HStack(spacing: 0) {
                if habit.startTimeMode {
                    TicketTime(label: habit.standardLabel, timeLabel: habit.standardTime.convertToString(), size: width * 0.35)
                } else {
                    TicketTime(label: habit.calculatedLabel, timeLabel: habit.calculatedTime, size: width * 0.35)
                }
                Spacer()
                if let actions = habit.actions?.allObjects as? [Action] {
                    let duration = actions.filter { $0.isOn }.reduce(0,{ $0 + $1.duration }).getString()
                    VStack(spacing: .miniSize) {
                        VStack {
                            Text(duration)
                                .font(.caption)
                            LongArrow()
                                .stroke(Color.accentColor, lineWidth: 1)
                                .frame(width: UIScreen.main.bounds.width * 0.17, height: 3)
                        }
                        Circle()
                            .opacity(0)
                            .frame(height: 30)
                    }.foregroundColor(.accentColor)
                }
                
                Spacer()
                if habit.startTimeMode {
                    TicketTime(label: habit.calculatedLabel, timeLabel: habit.calculatedTime, size: width * 0.35)
                } else {
                    TicketTime(label: habit.standardLabel, timeLabel: habit.standardTime.convertToString(), size: width * 0.35)
                }
            }
            .padding(.regularSize)
        }
        .background(.white)
        .frame(maxWidth: .infinity)
        .cornerRadius(12)
    }
}

#Preview {
    Ticket(habit: Habit.example)
}
