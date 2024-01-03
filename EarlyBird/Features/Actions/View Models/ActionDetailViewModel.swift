//
//  ActionDetailViewModel.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 31/12/2023.
//

import SwiftUI

class ActionDetailViewModel: ObservableObject {
    var habit: Habit
    
    @Published var action: Action?
    
    @Published var textFieldValue: String = ""
    
    @Published var hours: Int = 00
    
    @Published var mins: Int = 00
    
    @Published var isOn = true
        
    init(action: Action? = nil, habit: Habit) {
        
        if let action = action {
            self.action = action
            self.textFieldValue = action.title
            self.hours = action.duration.getTime().hours
            self.mins = action.duration.getTime().minutes
            self.isOn = action.isOn
        }
        self.habit = habit
    }

    func handleSaveButtonTapped() {
        let title = textFieldValue.trimmingCharacters(in: .whitespaces)
        let duration = Double(hours * 3600 + mins * 60)

        // update
        if let action = action {
    
            ActionStorage.shared.update(withId: action.id, title: title, duration: duration, isOn: isOn, habit: habit)
        } else {
            ActionStorage.shared.add(title: title, duration: duration, isOn: isOn, habit: habit)
        }
    }
    

}
