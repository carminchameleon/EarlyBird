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
    var startLabel: String {
        get { startLabel_ ?? "" }
        set { startLabel_ = newValue }
    }

    var startTime: Date {
        get { startTime_ ?? Date.now }
        set { startTime_ = newValue }
    }
    
    var finishTime: Date {
        get { finishTime_ ?? Date.now }
        set { finishTime_ = newValue }
    }
    
    var finishLabel: String {
        get { finishLabel_ ?? "" }
        set { finishLabel_ = newValue }
    }

    var sortBy: String {
        get { sortBy_ ?? "" }
        set { sortBy_ = newValue }
    }
}

