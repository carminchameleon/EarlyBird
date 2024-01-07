//
//  CycleViewModel.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 7/1/2024.
//

import SwiftUI

class CycleViewModel: ObservableObject {
    @State var startTime: Date = Date()
    @State var endTime: Date = Date()
    @State var numberOfCycles: Int = 0
    @State var sessionDuration: Int = 0 {
        didSet {
            print(sessionDuration)
        }
    }
    @State var breakDuration: Int = 0
    @State var sessionsBeforeBreak: Int = 0
    @State var endTimeMode = true
    
    let sessionList = [15, 20, 30, 40, 50, 60]

    let cycleList = [CycleTime(15), CycleTime(20), CycleTime(30), CycleTime(40), CycleTime(50), CycleTime(60)]
    let breakList = [CycleTime(0), CycleTime(5), CycleTime(10), CycleTime(15), CycleTime(20), CycleTime(25)]

    func calculateStudySchedule(startTime: String, endTime: String, sessionDuration: Int, breakDuration: Int, sessionsBeforeBreak: Int) -> [(String, String)] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"

        guard let start = dateFormatter.date(from: startTime),
              let end = dateFormatter.date(from: endTime) else {
            return []
        }

        var current = start
        var schedule = [(String, String)]()
        var sessionCount = 0

        while current.addingTimeInterval(TimeInterval(sessionDuration * 60)) <= end {
            let sessionEnd = current.addingTimeInterval(TimeInterval(sessionDuration * 60))
            schedule.append((dateFormatter.string(from: current), dateFormatter.string(from: sessionEnd)))
            current = sessionEnd
            sessionCount += 1

            if sessionCount % sessionsBeforeBreak == 0 {
                let breakEnd = current.addingTimeInterval(TimeInterval(breakDuration * 60))
                if breakEnd > end {
                    break
                }
                schedule.append((dateFormatter.string(from: current), dateFormatter.string(from: breakEnd)))
                current = breakEnd
            }
        }

        return schedule
    }
}
