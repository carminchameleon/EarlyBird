//
//  HabitListViewModel.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 30/12/2023.
//

import Foundation
import Combine

class HabitListViewModel: ObservableObject {
    @Published var habits: [Habit] = []
    private var cancellable: AnyCancellable?
    var selectedItem: Habit?
    
    init(habitPublisher: AnyPublisher<[Habit], Never> = HabitStorage.shared.habits.eraseToAnyPublisher()) {
        cancellable = habitPublisher
            .removeDuplicates()
            .sink { habits in
            print("✅ Update Habit List View")
            self.habits = habits
        }
    }

    func handleShowDetail(_ item: Habit) {
        selectedItem = item
    }
    
    func deleteItem(_ id: UUID) {
        HabitStorage.shared.delete(withId: id)
    }
    
    func moveItem(_ from: IndexSet, _ to: Int) {
        habits.move(fromOffsets: from, toOffset: to)
    }
}
