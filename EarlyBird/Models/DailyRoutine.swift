//
//  Routine.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 24/12/2023.
//

import Foundation
import SwiftUI

struct Routine: Identifiable, Hashable, Equatable {
    var id = UUID()
    var title: String = ""
    var standardTime = Date()
    var standardLabel = "✅ End Time"
    var calculatedTime = ""
    var calculatedLabel = ""
    var startTimeMode = false
    var activities: [Activity] = []
    var color: Color = .accentColor
    
    init(id: UUID = UUID(), title: String, standardTime: Date, standardLabel: String, calculatedTime: String, calculatedLabel: String, startTimeMode: Bool, activities: [Activity], color: Color = .accentColor) {
        self.id = id
        self.title = title
        self.standardLabel = standardLabel
        self.standardTime = standardTime
        self.calculatedLabel = calculatedLabel
        self.startTimeMode = startTimeMode
        self.color = color
        self.activities = activities
    }
    
    func updateRoutine(routine: Routine) -> Routine {
        return Routine(id: id, title: routine.title, standardTime: routine.standardTime, standardLabel: routine.standardLabel, calculatedTime: routine.calculatedTime, calculatedLabel: routine.calculatedLabel, startTimeMode: routine.startTimeMode, activities: routine.activities)
    }
    
    static func == (lhs: Routine, rhs: Routine) -> Bool {
        return lhs.id == rhs.id
    }
    
    // create a hash() function to only compare  age property
     func hash(into hasher: inout Hasher) {
       hasher.combine(id)
     }
    
}

extension Routine {
    static var mockedStartRoutine = Routine(title: "Daily Morning", standardTime: "7:00 AM".convertToDate() ?? Date(), standardLabel: "Wake Up", calculatedTime: "", calculatedLabel: "Start Working", startTimeMode: true, activities: [
        Activity(title: "1 _ Yoga", duration: 1200),
        Activity(title: "2 - Drink Hot Water", duration: 60),
        Activity(title: "3 _ Organize bed", duration: 120),
        Activity(title: "4 _ Morning Page", duration: 2400),
    ], color: .orange)

    static var mockedFinishRoutine = Routine(title: "Night Routine", standardTime: "11:30 PM".convertToDate() ?? Date(), standardLabel: "Go to bed", calculatedTime: "", calculatedLabel: "Finish Working", startTimeMode: false, activities: [
        Activity(title: "Organize working desk", duration: 1200),
        Activity(title: "Have a Dinner", duration: 60),
        Activity(title: "Reading a book", duration: 120),
        Activity(title: "Take a shower", duration: 2400),
    ])
    
    static var mockedRoutine = Routine(id: UUID(),
                                       title: "Weekly Routine",
                                       standardTime: Date(),
                                       standardLabel: "✅ End Time",
                                       calculatedTime: "",
                                       calculatedLabel:  "⏰ Wake Up",
                                       startTimeMode: false,
                                       activities: [
                                        Activity(title: "Morning Page", duration: 1200),
                                        Activity(title: "Drink Hot Water", duration: 60),
                                        Activity(title: "Organize bed", duration: 120),
                                        Activity(title: "Working Out", duration: 2400),
                                        Activity(title: "Laundary", duration: 2400),
                                    ])
}
