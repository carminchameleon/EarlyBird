//
//  HabitRow.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 30/12/2023.
//

import SwiftUI

struct HabitRow: View {
    @ObservedObject var habit: Habit 
    
    var body: some View {
        VStack {
            HStack {
                ZStack {
                    Circle()
                        .fill(Color.accentColor.opacity(0.2))
                        .frame(width:30)
                    Text(habit.startTimeMode ? "🏁": "🚀")
                        .font(.caption)
                }
                Text(habit.title)
                    .font(.title3)
                    .bold()
                    .fontDesign(.serif)
                    .foregroundColor(Color.accentColor)
                Spacer()
                if let actions = habit.actions?.allObjects as? [Action] {
                    Text("\(actions.count)")
                        .foregroundStyle(.secondary)
                        .font(.title2)
                        .fontDesign(.rounded)
                        .bold()
                }
            }
            Spacer()
            HStack {
                Text(habit.standardLabel)
                Text(habit.standardTime.convertToString())
                if let actions = habit.actions?.allObjects as? [Action] {
                    let duration = actions.filter { $0.isOn }.reduce(0,{ $0 + $1.duration }).getString()
                    Text("\(duration)")
                }
                Spacer()
            }
            .font(.caption)
            .fontWeight(.semibold)
            .foregroundStyle(.secondary)
        }
        .padding(.vertical, .smallSize)
        .frame(height: 90)
    }
}





#Preview {
    HabitRow(habit: Habit.example)
}
