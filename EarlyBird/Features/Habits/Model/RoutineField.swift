//
//  RoutineField.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 26/12/2023.
//

import Foundation

enum RoutineField: Int {
    case start
    case end
    
    var title: String {
        switch self {
        case .start: return "When it Finishes"
        case .end: return "When to Start"
        }
    }
    
    var standardGuide: String {
        switch self {
        case .start: return "Trigger Action & Time"
        case .end: return "Wrap-up Action & Time"
        }
    }
    
    var standardPlaceholder: String {
        switch self {
        case .start: return "Wake Up, Finish Working"
        case .end: return "Arrive at Work, Get into Bed"
        }
    }
    
    var calculatedGuide: String {
        switch self {
        case .start: return "End Point"
        case .end: return "Start Point"
        }
    }
    
    var calculatedPlaceholder: String {
        switch self {
        case .start: return "Arrive at Work, Get into Bed"
        case .end: return "Wake Up, Desk Time"
        }
    }
}
