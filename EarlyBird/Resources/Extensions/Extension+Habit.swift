//
//  Extension+Habit.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 30/12/2023.
//

import Foundation
import UIKit

extension Habit {
    public var id: UUID {
        get { id_ ?? UUID() }
        set { id_ = newValue }
    }
    
    var title: String {
        get { title_ ?? "" }
        set { title_ = newValue }
    }
    
    var standardTime: Date {
        get { standardTime_ ?? Date.now }
        set { standardTime_ = newValue }
    }
    
    var standardLabel: String {
        get { standardLabel_ ?? "" }
        set { standardLabel_ = newValue }
    }
    
    var calculatedTime: String {
        get { calculatedTime_ ?? "" }
        set { calculatedTime_ = newValue }
    }
    
    var calculatedLabel: String {
        get { calculatedLabel_ ?? "" }
        set { calculatedLabel_ = newValue }
    }

    var sortBy: String {
        get { sortBy_ ?? "" }
        set { sortBy_ = newValue }
    }
    
    
    static var example: Habit {
        let context = PersistenceController.preview.container.viewContext
        let habit = Habit(context: context)
        habit.id = UUID()
        habit.title = "Weekly Routine"
        habit.standardTime = Date()
        habit.standardLabel = "✅ End Time"
        habit.calculatedTime = ""
        habit.calculatedLabel =  "⏰ Wake Up"
        habit.startTimeMode = false
        
        return habit
    }
}
