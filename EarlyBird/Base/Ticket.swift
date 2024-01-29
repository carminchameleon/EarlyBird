//
//  Ticket.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 28/1/2024.
//

import SwiftUI

struct Ticket: View {
    @ObservedObject var habit: Habit {
        didSet {
            print(habit)
        }
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
            
//            .clipShape(.rect(topLeadingRadius: 12, topTrailingRadius: 12))
            HStack(spacing: 0) {
                if habit.startTimeMode {
                    TimeComponent(label: habit.standardLabel, timeLabel: habit.standardTime.convertToString(), size: UIScreen.main.bounds.width * 0.35)
                } else {
                    TimeComponent(label: habit.calculatedLabel, timeLabel: habit.calculatedTime, size: UIScreen.main.bounds.width * 0.35)
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
                    TimeComponent(label: habit.calculatedLabel, timeLabel: habit.calculatedTime, size: UIScreen.main.bounds.width * 0.35)
                } else {
                    TimeComponent(label: habit.standardLabel, timeLabel: habit.standardTime.convertToString(), size: UIScreen.main.bounds.width * 0.35)
                }
            }
            .padding(.regularSize)
        }
        .background(.white)
        .frame(maxWidth: .infinity)
        .cornerRadius(12)
//        .overlay(
//            RoundedRectangle(cornerRadius: 12)
//                .stroke(Color.red, lineWidth: 1)
//        )

    }
}

#Preview {
    Ticket(habit: Habit.example)
}

struct TimeComponent: View {
    var label: String
    var timeLabel: String
    var isDay: Bool = true
    var size: CGFloat
    
    var body: some View {
        VStack(spacing: .smallSize) {
            VStack(alignment: .trailing, spacing: 0) {
                Text(isDay ? "AM": "PM")
                    .font(.system(size: 9))
                Text(timeLabel)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
                    .font(.system(size: 28, weight: .bold, design: .rounded))
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

