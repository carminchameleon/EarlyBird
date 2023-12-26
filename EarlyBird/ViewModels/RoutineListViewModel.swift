//
//  RoutineListViewModel.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 24/12/2023.
//

import Foundation

class RoutineListViewModel: ObservableObject {
    @Published var routines: [Routine] = [Routine.mockedRoutine]
    
    // CREATE
    func addItem(routine: Routine) {
        routines.append(routine)
    }
    // UPDATE
    func updateItem(routine: Routine) {
            
    }

    func moveItem(from: IndexSet, to: Int) {
        routines.move(fromOffsets: from, toOffset: to)
    }
    
    // DELETE
    func deleteItem(indexSet: IndexSet) {
        routines.remove(atOffsets: indexSet)
    }
}
