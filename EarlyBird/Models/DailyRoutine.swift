//
//  Routine.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 24/12/2023.
//

import Foundation
import SwiftUI

struct Routine: Identifiable, Hashable, Equatable {
    static func == (lhs: Routine, rhs: Routine) -> Bool {
        return lhs.id == rhs.id
    }
    
    // create a hash() function to only compare  age property
     func hash(into hasher: inout Hasher) {
       hasher.combine(id)
     }
    
    var id = UUID().uuidString
    var title: String = ""
    var standardTime = Date()
    var standardLabel = "✅ End Time"
    var calculatedTime = ""
    var calculatedLabel = ""
    var startTimeMode = false
    var activities: [Activity] = []
    var color: Color = .accentColor
}

extension Routine {
    static var mockedRoutine = Routine(id: "1",
                                       title: "Morning Routine",
                                       standardTime: Date(),
                                       standardLabel: "✅ End Time",
                                       calculatedTime: "",
                                       calculatedLabel:  "⏰ Wake Up",
                                       startTimeMode: false,
                                       activities: Activity.mockedActivity)
}
