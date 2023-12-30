//
//  RoutineDetailViewModel.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 29/12/2023.
//

import Foundation
import SwiftUI

class RoutineDetailViewModel: ObservableObject {
    let manager = CoreDataManager.instance
    var routine: RoutineEntity?
    
    @Published var name = ""
    @Published var standardLabel = ""
    @Published var standardTime = Date()
    @Published var calculatedLabel = ""
    @Published var startTimeMode = true
    
    @Published var standardGuide: String = RoutineField.start.standardGuide
    @Published var calculatedGuide: String = RoutineField.end.calculatedGuide
    @Published var startPlaceholder: String = RoutineField.start.standardPlaceholder
    @Published var calculatedPlaceholder: String = RoutineField.start.calculatedPlaceholder
    @Published var color: Color = .accentColor
    
    var saveRoutine: (RoutineEntity) -> ()
    
    private var cancelBag = CancelBag()

    init(routine: RoutineEntity? = nil, saveRoutine: @escaping ((RoutineEntity) -> Void)) {
        if let routine = routine {
            self.routine = routine
            self.name = routine.name
            self.standardLabel = routine.standardLabel
            self.standardTime = routine.standardTime
            self.calculatedLabel = routine.calculatedLabel
            self.startTimeMode = routine.startTimeMode
//            self.color = Color(routine.uiColor)
        }
        
        self.saveRoutine = saveRoutine
        addModeSubscriber()
        
    }
    
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
    
    
    func saveButtonTapped() {
        // need to send current datas
        if let routine = routine {
            // update routine
            updateRoutine(routine)
        } else {
            makeNewRoutine()
        }
    
    }
    
    func makeNewRoutine() {
        let newRoutine = RoutineEntity(context: manager.context)
        newRoutine.id = UUID()
        newRoutine.name = name
        newRoutine.standardTime = standardTime
        newRoutine.standardLabel = standardLabel
        newRoutine.calculatedTime = ""
        newRoutine.calculatedLabel = calculatedLabel
        newRoutine.startTimeMode = startTimeMode
        newRoutine.color = color.toHex()
        newRoutine.duration = 0
        print("✅new routine is added")
        manager.saveContext()
    }
    
    func updateRoutine(_ routine: RoutineEntity) {
        let existRoutine = routine
        existRoutine.name = name
        existRoutine.standardTime = standardTime
        existRoutine.standardLabel = standardLabel
        existRoutine.calculatedTime = ""
        existRoutine.calculatedLabel = calculatedLabel
        existRoutine.startTimeMode = startTimeMode
        existRoutine.color = color.toHex()
        
        manager.saveContext()
    }
    
    func deleteRoutine() {
        if let routine = routine {
            manager.context.delete(routine)
            manager.saveContext()
        }
    }
}
