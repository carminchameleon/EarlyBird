//
//  ActionListViewModel.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 31/12/2023.
//

import Foundation
import SwiftUI
import Combine
import CoreData
import UIKit


class ActionListViewModel: ObservableObject {
    var habit: Habit
    @Published var title: String = ""
    @Published var standardTime = Date()
    @Published var standardLabel = "✅ End Time"
    @Published var calculatedTime = ""
    @Published var calculatedLabel = "⏰ Wake Up"
    @Published var startTimeMode: Bool = false
    @Published var actions: [Action] = []
    var color: Color = .accentColor
    
    var sortOption = SortOption.manual
    var sortOrder = SortOrder.ascend
    
    @Published var selectedItem: Action? = nil
    @Published var duration: TimeInterval = 0
    
    var cancelBag = CancelBag()
    
    init(habit: Habit) {
        self.habit = habit
        self.title = habit.title
        self.standardTime = habit.standardTime
        self.standardLabel = habit.standardLabel
        self.calculatedTime = habit.calculatedTime
        self.calculatedLabel = habit.calculatedLabel
        self.startTimeMode = habit.startTimeMode
        
        if let actions = habit.actions?.allObjects as? [Action] {
            self.actions = actions
        }
        
        self.color = Color(habit.color)
        addActivitiesSubscriber()
        addDurationSubscriber()
    }
    
    // MARK: - get newest data
    func updateHabitData() {
        if let habit = HabitStorage.shared.fetchEntityWithId(habit.id) {
            self.habit = habit
            self.title = habit.title
            self.standardTime = habit.standardTime
            self.standardLabel = habit.standardLabel
            self.calculatedTime = habit.calculatedTime
            self.calculatedLabel = habit.calculatedLabel
            self.startTimeMode = habit.startTimeMode
            
            let actions = fetchActionData(habit: habit)
            self.actions = actions
        }
    }
    
    func fetchActionData(habit: Habit) -> [Action] {
        print("FETCH ACTION DATA")
        let fetchRequest: NSFetchRequest<Action> = Action.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "habit == %@", habit)
        fetchRequest.sortDescriptors = []
        do {
            let entities = try PersistenceController.shared.container.viewContext.fetch(fetchRequest)
            return entities
        } catch {
            let nsError = error as NSError
            fatalError("Unresolve error \(nsError), \(nsError.userInfo)")
        }
    }
    
    // MARK: - Subscribers
    func addActivitiesSubscriber() {
        $actions.map { action in
            // activities 리스트를 전체 다 받을 예정임
            let duration = self.actions.filter { $0.isOn }.reduce(0,{ $0 + $1.duration })
            return duration
        }.sink {[weak self] returnedValue in
            guard let self = self else { return }
            self.duration = returnedValue
        }.store(in: cancelBag)
    }

    
    func addDurationSubscriber() {
        $duration.combineLatest($standardTime, $startTimeMode)
            .receive(on: DispatchQueue.main)
            .sink {[weak self] (duration, standardTime, startTimeMode) in
                self?.updateCalculateTime(standardTime: standardTime, duration: duration, startTimeMode: startTimeMode)
            }.store(in: cancelBag)
    }
    
    func updateCalculateTime(standardTime: Date, duration: TimeInterval, startTimeMode: Bool) {
        var dateFormmater: DateFormatter {
            let formatter = DateFormatter()
            formatter.dateStyle = .none
            formatter.timeStyle = .short
            return formatter
        }
        
        let resultDate = standardTime.addingTimeInterval( startTimeMode ? duration : -duration )
        calculatedTime = dateFormmater.string(from: resultDate)
    }
    
    // MARK: - Switch Mode
    func switchButtonTapped() {
        guard let existCalculatedTime = calculatedTime.convertToDate() else { return }
        standardTime = existCalculatedTime
        startTimeMode.toggle()
        
        let existCalculatedLabel = calculatedLabel
        let existStandardLabel = standardLabel
        
        standardLabel = existCalculatedLabel
        calculatedLabel = existStandardLabel
    }
    
    func backButtonTapped() {
    
        HabitStorage.shared.updateDetail(habit: habit,
                                         standardLabel: standardLabel,
                                         standardTime: standardTime,
                                         calculatedLabel: calculatedLabel,
                                         calculatedTime: calculatedTime,
                                         startTimeMode: startTimeMode,
                                         duration: duration)
    }
    
    
    func deleteItem(indexSet: IndexSet) {
        print("delete item")
        
        if let firstIndex = indexSet.first {
            let id = actions[firstIndex].id
            ActionStorage.shared.delete(withId: id)
        }        
    }
    
    func moveItem(from: IndexSet, to: Int) {
        sortOption = .manual
        sortOrder = .ascend
        actions.move(fromOffsets: from, toOffset: to)
    }
        
    func updateToggleState(item: Action) {
//        if let index = activities.firstIndex(where: { $0.id == item.id }) {
//            activities[index] = item.updateToggle()
//        }
//        sortActivityList()
    }
    
    func addItem(item: Action) {
//        activities.append(item)
//        sortActivityList()
    }
    
    func presetButtonTapped(_ item: SelectableTime) {
        var duration: Double = 0
        switch item.type {
        case .hours:
            duration = Double(item.number) * 3600
        case .minutes:
            duration = Double(item.number) * 60
        case .seconds:
            break
        }
        print(duration)
    }
    
    func updateSortOption(_ newOption: SortOption) {
        self.sortOption = newOption
        actions = getSortedList(newOption, sortOrder)
    }
    
    func updateSortOrder(_ newOrder: SortOrder) {
        self.sortOrder = newOrder
        actions = getSortedList(sortOption, newOrder)
    }
    
    
    func getSortedList(_ sortOption: SortOption,_ sortOrder: SortOrder ) -> [Action] {
        var list = actions
        switch sortOption {
        case .manual:
            break
        case .title:
            switch sortOrder {
            case .ascend:
                list = list.sorted { $0.title < $1.title }
            case .descend:
                list = list.sorted { $0.title > $1.title }
            }
            
        case .active:
            switch sortOrder {
            case .ascend:
                list = list.sorted { $0.isOn && !$1.isOn }
            case .descend:
                list = list.sorted { !$0.isOn && $1.isOn }
            }
            
        case .duration:
            switch sortOrder {
            case .ascend:
                list = list.sorted { $0.duration < $1.duration }
            case .descend:
                list = list.sorted { $0.duration > $1.duration }
            }
        }
        
        return list
    }
}
