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
        habit.calculatedTime = Date().convertToString()
        habit.calculatedLabel =  "⏰ Wake Up"
        habit.startTimeMode = false
        
        return habit
    }
    
    
    static var onboard: Habit {
        
        let startString = "7:00"
        let timeString = "1:22"
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "H:mm"

        let startDate = dateFormatter.date(from: startString) ?? Date()
        let date = dateFormatter.date(from: timeString) ?? Date().addingTimeInterval(200)
        
        let context = PersistenceController.preview.container.viewContext
        let habit = Habit(context: context)
        habit.id = UUID()
        habit.title = "Your brilliant Future"
        habit.standardTime = startDate
        habit.standardLabel = "FROM NOW"
        habit.calculatedTime = date.convertToString()
        habit.calculatedLabel =  "TIPPING POINT"
        habit.startTimeMode = true
        
        return habit
    }
}
