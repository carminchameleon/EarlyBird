//
//  RoutineSettingViewModel.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 24/12/2023.
//

import Foundation
import SwiftUI

enum TimeConfig: Int {
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

class RoutineSettingViewModel: ObservableObject {
    @Published var title = ""
    @Published var standardTitle = ""
    @Published var standardTime = Date()
    
    @Published var calculatedTitle = ""

    @Published var isStartSelected: TimeConfig.RawValue = 0
    @Published var startTimeMode = true
    @Published var standardGuide: String = TimeConfig.start.standardGuide
    @Published var calculatedGuide: String = TimeConfig.end.calculatedGuide
    @Published var startPlaceholder: String = TimeConfig.start.standardPlaceholder
    @Published var calculatedPlaceholder: String = TimeConfig.start.calculatedPlaceholder
    @Published var color: Color = Color(UIColor.blue)
    @Published var emoji: String = "⏳"
    
    private var cancelBag = CancelBag()
    
    // after select mode
    // need to change guide lines
    init() {
        addModeSuscriber()
    }
    
    func modeSelected(isStart: Bool) {
        startTimeMode = isStart
    }
    
    // combine publisher
    func addModeSuscriber() {
        $startTimeMode
            .receive(on: DispatchQueue.main)
            .sink {[weak self] isStartMode in
                print(isStartMode)
                if isStartMode {
                    self?.standardGuide = TimeConfig.start.standardGuide
                    self?.calculatedGuide = TimeConfig.start.calculatedGuide
                    self?.startPlaceholder = TimeConfig.start.standardPlaceholder
                    self?.calculatedPlaceholder = TimeConfig.start.calculatedPlaceholder
                } else {
                    self?.standardGuide = TimeConfig.end.standardGuide
                    self?.calculatedGuide = TimeConfig.end.calculatedGuide
                    self?.startPlaceholder = TimeConfig.end.standardPlaceholder
                    self?.calculatedPlaceholder = TimeConfig.end.calculatedPlaceholder

                }
            }.store(in: cancelBag)
    }
}
