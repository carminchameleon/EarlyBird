//
//  Activity.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 25/11/2023.
//

import Foundation

struct Activity: Identifiable {
    let id: String
    let title: String
    let duration: Double
    var isOn: Bool
    
    init(id: String = UUID().uuidString, title: String, duration: Double, isOn: Bool = true) {
        self.id = id
        self.title = title
        self.duration = duration
        self.isOn = isOn
    }
    
    func updateTitle(newTitle: String, newDuration: TimeInterval, isOn: Bool) -> Activity {
        return Activity(id: id, title: newTitle, duration: newDuration, isOn: isOn)
    }

    func updateToggle() -> Activity {
        return Activity(id: id, title: title, duration: duration, isOn: isOn)
    }
}
