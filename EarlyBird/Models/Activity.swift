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
    
    init(id: String = UUID().uuidString, title: String, duration: Double) {
        self.id = id
        self.title = title
        self.duration = duration
    }
    
    func updateTitle(newTitle: String, newDuration: TimeInterval) -> Activity {
        return Activity(id: id, title: newTitle, duration: newDuration)
    }
}
