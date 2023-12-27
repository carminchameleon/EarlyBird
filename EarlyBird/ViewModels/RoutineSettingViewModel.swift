//
//  RoutineSettingViewModel.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 24/12/2023.
//

import Foundation
import SwiftUI


class RoutineSettingViewModel: ObservableObject {
    @Published var title = ""
    @Published var standardLabel = ""
    @Published var standardTime = Date()
    @Published var calculatedLabel = ""
    @Published var isStartSelected: RoutineField.RawValue = 0
    @Published var startTimeMode = true
    
    @Published var standardGuide: String = RoutineField.start.standardGuide
    @Published var calculatedGuide: String = RoutineField.end.calculatedGuide
    @Published var startPlaceholder: String = RoutineField.start.standardPlaceholder
    @Published var calculatedPlaceholder: String = RoutineField.start.calculatedPlaceholder
    @Published var color: Color = .accentColor
    
    @Published var saveDisabled = false
    
    private var cancelBag = CancelBag()
    
    var saveRoutine: (Routine) -> ()
    
    // after select mode
    // need to change guide lines
    init(routine: Routine? = nil, saveRoutine: @escaping ((Routine)->Void)){
        if let routine = routine {
            self.title = routine.title
            self.standardLabel = routine.standardLabel
            self.standardTime = routine.standardTime
            self.calculatedLabel = routine.calculatedLabel
            self.startTimeMode = routine.startTimeMode
            self.color = routine.color
        }
        self.saveRoutine = saveRoutine
        addModeSubscriber()
        addFieldStateSubscriber()
    }
    
    func modeSelected(isStart: Bool) {
        startTimeMode = isStart
    }
    
    // combine publisher
    func addModeSubscriber() {
        $startTimeMode
            .receive(on: DispatchQueue.main)
            .sink {[weak self] isStartMode in
                
                if isStartMode {
                    self?.standardGuide = RoutineField.start.standardGuide
                    self?.calculatedGuide = RoutineField.start.calculatedGuide
                    self?.startPlaceholder = RoutineField.start.standardPlaceholder
                    self?.calculatedPlaceholder = RoutineField.start.calculatedPlaceholder
                } else {
                    self?.standardGuide = RoutineField.end.standardGuide
                    self?.calculatedGuide = RoutineField.end.calculatedGuide
                    self?.startPlaceholder = RoutineField.end.standardPlaceholder
                    self?.calculatedPlaceholder = RoutineField.end.calculatedPlaceholder

                }
            }.store(in: cancelBag)
    }
    
    func addFieldStateSubscriber() {
        $title
            .combineLatest($standardLabel, $calculatedLabel)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {[weak self] title, standardLabel, calculatedLabel in
                if title.count > 0, standardLabel.count > 0, calculatedLabel.count > 0 {
                    self?.saveDisabled = false
                } else {
                    self?.saveDisabled = true
                }
            })
            .store(in: cancelBag)
    }
    
   
    
   
    
}
