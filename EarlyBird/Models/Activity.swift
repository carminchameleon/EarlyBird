//
//  Activity.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 25/11/2023.
//

import Foundation

struct Activity: Identifiable {
    let id: String
    var title: String
    var duration: Double
    var isOn: Bool
    
    init(id: String = UUID().uuidString, title: String, duration: Double, isOn: Bool = true) {
        self.id = id
        self.title = title
        self.duration = duration
        self.isOn = isOn
    }
    
    func updateActivity(newTitle: String, newDuration: TimeInterval, isOn: Bool) -> Activity {
        return Activity(id: id, title: newTitle, duration: newDuration, isOn: isOn)
    }

    func updateToggle() -> Activity {
        return Activity(id: id, title: title, duration: duration, isOn: isOn)
    }
}

extension Activity {
    static let mockedActivity = [
        Activity(title: "Yoga", duration: 1200),
        Activity(title: "Drink Hot Water", duration: 60),
        Activity(title: "Organize bed", duration: 120),
        Activity(title: "Morning Page", duration: 2400),
    ]
}
