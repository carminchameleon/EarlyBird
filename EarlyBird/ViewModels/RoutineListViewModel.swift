//
//  RoutineListViewModel.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 24/12/2023.
//

import Foundation

class RoutineListViewModel: ObservableObject {
    @Published var routines: [Routine] = [Routine.mockedRoutine]
}
