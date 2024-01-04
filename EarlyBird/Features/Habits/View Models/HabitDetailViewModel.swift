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
    @Published var standardLabel = ""
    @Published var standardTime = Date()
    @Published var calculatedLabel = ""
    @Published var isStartSelected: RoutineField.RawValue = 0
    @Published var startTimeMode = true
    
    @Published var standardGuide: String = RoutineField.start.standardGuide
    @Published var calculatedGuide: String = RoutineField.end.calculatedGuide
    @Published var startPlaceholder: String = RoutineField.start.standardPlaceholder
    @Published var calculatedPlaceholder: String = RoutineField.start.calculatedPlaceholder
    
    private var cancelBag = CancelBag()
    
    init(habit: Habit? = nil) {
        print("Habit detail view model is initilized")
        if let habit = habit {
            self.title = habit.title
            self.standardLabel = habit.standardLabel
            self.standardTime = habit.standardTime
            self.calculatedLabel = habit.calculatedLabel
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
            // update habit
            HabitStorage.shared.update(withId: habit.id,
                                       title: title,
                                       standardLabel: standardLabel,
                                       standardTime: standardTime,
                                       calculatedLabel: calculatedLabel,
                                       startTimeMode: startTimeMode)
        } else {
            // add new habit
            HabitStorage.shared.add(title: title, 
                                    standardLabel: standardLabel,
                                    standardTime: standardTime,
                                    calculatedLabel: calculatedLabel,
                                    startTimeMode: startTimeMode)
        }
    }
}
