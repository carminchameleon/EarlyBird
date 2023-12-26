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
        HStack {
            ZStack {
                Circle()
                    .fill(routine.color.gradient.opacity(0.2))
                    .frame(width:24)
                Image(systemName: "tray")
                    .font(.caption)
                    .aspectRatio(1.0, contentMode: .fit)
                    .foregroundColor(routine.color)
            }
            Text(routine.title)
            Spacer()
            Text("\(routine.activities.count)")
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    Group {
        RoutineRow(routine: Routine.mockedRoutine)
            .environmentObject(RoutineListViewModel())
        RoutineRow(routine: Routine.mockedRoutine)
            .environmentObject(RoutineListViewModel())

    }
}
