//
//  RoutineSettingViewModel.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 24/12/2023.
//

import Foundation

enum TimeConfiguration: Int {
    case start
    case end
    
    var title: String {
        switch self {
        case .start: return "When to Start"
        case .end: return "When it Finishes"
        }
    }
    
    var standardGuideTitle: String {
        switch self {
        case .start: return "Wrap-up Action & Time"
        case .end: return "Trigger Action & Time"
        }
    }
    
    var calculatedLabel: String {
        switch self {
        case .start: return "Trigger Action"
        case .end: return "Wrap-up Action"
        }
    }
}

class RoutineSettingViewModel: ObservableObject {
    
    @Published var title = "Working Routine"
    @Published var standardTitle = "⏰ Wake Up"
    @Published var standardTime = Date()
    
    @Published var calculatedTitle = "Arrive at office"

    @Published var isStartSelected: TimeConfiguration.RawValue = 0
    @Published var standardGuideTitle: String = TimeConfiguration.start.standardGuideTitle
    @Published var calculatedGuideTitle: String = TimeConfiguration.start.calculatedLabel

}

class Routine {
    var title: String = ""
    var standardTime = Date()
    var standardLabel = "✅ End Time"
    var calculatedTime = ""
    var calculatedLabel = "⏰ Wake Up"
    var startTimeMode = false
    var activities: [Activity] = []
}
