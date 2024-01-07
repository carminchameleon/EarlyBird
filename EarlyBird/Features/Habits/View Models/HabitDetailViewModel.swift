//
//  HabitDetailViewModel.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 30/12/2023.
//

import Foundation
import SwiftUI

class HabitDetailViewModel: ObservableObject {
    var habit: Habit?
    
    @Published var title = ""
    
    @Published var startLabel = ""
    @Published var startTime = Date()
    
    @Published var finishLabel = ""
    @Published var finishTime = Date()
    
    @Published var isStartSelected: RoutineField.RawValue = 0
    @Published var startTimeMode = true
    
    @Published var standardGuide: String = RoutineField.start.standardGuide
    @Published var calculatedGuide: String = RoutineField.end.calculatedGuide
    @Published var startPlaceholder: String = RoutineField.start.standardPlaceholder
    @Published var calculatedPlaceholder: String = RoutineField.start.calculatedPlaceholder
    
    private var cancelBag = CancelBag()
    
    init(habit: Habit? = nil) {
        if let habit = habit {
            self.title = habit.title
            self.startLabel = habit.startLabel
            self.startTime = habit.startTime ?? Date.now
            self.finishTime = habit.finishTime ?? Date.now
            self.finishLabel = habit.finishLabel
            self.startTimeMode = habit.startTimeMode
            self.habit = habit
        }
        addModeSubscriber()
    }

    func addModeSubscriber() {
        $startTimeMode
            .receive(on: DispatchQueue.main)
            .sink {[weak self] isStartMode in
                if isStartMode {
                    
                    self?.standardGuide = RoutineField.start.standardGuide
                    self?.calculatedGuide = RoutineField.start.calculatedGuide
                    self?.startPlaceholder = RoutineField.start.standardPlaceholder
                    self?.calculatedPlaceholder = RoutineField.start.calculatedPlaceholder
                } else {
                    self?.standardGuide = RoutineField.end.standardGuide
                    self?.calculatedGuide = RoutineField.end.calculatedGuide
                    self?.startPlaceholder = RoutineField.end.standardPlaceholder
                    self?.calculatedPlaceholder = RoutineField.end.calculatedPlaceholder

                }
            }.store(in: cancelBag)
    }
    
    func saveButtonTapped() {
        if let habit = habit {
           updateHabit(habit: habit)
        } else {
            addNewHabit()
        }
    }
    
    func updateHabit(habit: Habit) {
        guard let actions = habit.actions?.allObjects as? [Action] else { return }
        let duration = actions.filter { $0.isOn }.reduce(0,{ $0 + $1.duration })
            
        if startTimeMode {
            let newFinishTime = startTime.addingTimeInterval(duration)
            HabitStorage.shared.update(withId: habit.id,
                                       title: title,
                                       startLabel: startLabel,
                                       startTime: startTime,
                                       finishLabel: finishLabel,
                                       finishTime: newFinishTime,
                                       startTimeMode: startTimeMode)
        } else {
            let newStartTime = finishTime.addingTimeInterval(-duration)
            HabitStorage.shared.update(withId: habit.id,
                                       title: title,
                                       startLabel: startLabel,
                                       startTime: newStartTime,
                                       finishLabel: finishLabel,
                                       finishTime: finishTime,
                                       startTimeMode: startTimeMode)
        }
    }
    
    func addNewHabit() {
        HabitStorage.shared.add(title: title,
                                startLabel: startLabel,
                                startTime: startTimeMode ? startTime : finishTime,
                                finishLabel: finishLabel,
                                finishTime: startTimeMode ? startTime : finishTime,
                                startTimeMode: startTimeMode)
    }
}
