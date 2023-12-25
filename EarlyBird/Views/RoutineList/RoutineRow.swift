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
            Label(routine.title, systemImage: "tray").tint(.gray)
            Spacer()
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
