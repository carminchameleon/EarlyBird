//
//  RoutineRow.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 24/12/2023.
//

import SwiftUI

struct RoutineRow: View {
    var routine: Routine
    
    var body: some View {
        VStack {
            HStack {
                ZStack {
                    Circle()
                        .fill(routine.color.gradient.opacity(0.2))
                        .frame(width:30)
                    Text(routine.startTimeMode ? "🚀": "🏁")
                        .font(.caption)

                }
                Text(routine.title)
                    .font(.title3)
                    .bold()
                    .fontDesign(.rounded)
                    .foregroundColor(routine.color)
                Spacer()                
                Text("\(routine.activities.count)")
                    .foregroundStyle(.secondary)
                    .font(.title2)
                    .fontDesign(.rounded)
                    .bold()
            }
            Spacer()
            HStack {
                Text(routine.standardLabel)
                Text(routine.standardTime.convertToString())
                Text(routine.activities.filter { $0.isOn }.reduce(0,{ $0 + $1.duration }).getString())
                Spacer()
            }
            .font(.caption)
            .fontWeight(.semibold)
            .foregroundStyle(.secondary)
        }
        .padding()
        .frame(height: 100)
        .background(Color(uiColor: .secondarySystemBackground))
        .cornerRadius(.largeSize)
    }
}

#Preview {
    Group {
        RoutineRow(routine: Routine.mockedStartRoutine)
            .environmentObject(RoutineListViewModel())
        RoutineRow(routine: Routine.mockedFinishRoutine)
            .environmentObject(RoutineListViewModel())

    }
}
