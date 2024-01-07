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
    
    @Published var startTime = Date()
    
    @Published var startLabel = "✅ End Time"
    
    @Published var finishTime = Date()
    
    @Published var finishLabel = "⏰ Wake Up"
    
    @Published var startTimeMode: Bool = false
    
    @Published var actions: [Action] = []
    
    @Published var seperateMode: Bool = false
    
    var sortOption = SortOption.manual
    var sortOrder = SortOrder.ascend
    
    @Published var selectedItem: Action? = nil
    @Published var duration: TimeInterval = 0
    
    var cancelBag = CancelBag()
    
    // init habit
    init(habit: Habit) {
        self.habit = habit
        self.title = habit.title
        self.startTime = habit.startTime
        self.startLabel = habit.startLabel
        self.finishTime = habit.finishTime
        self.finishLabel = habit.finishLabel
        self.startTimeMode = habit.startTimeMode
        
        sortOption = SortOption(rawValue: habit.sortBy) ?? .manual
        sortOrder = habit.isAscending ? .ascend : .descend
        
        if let actions = habit.actions?.allObjects as? [Action] {
            self.actions = actions
            self.actions = getSortedList(sortOption, sortOrder)

        }
        addActivitiesSubscriber()
        addDurationSubscriber()
    }
    
    // MARK: - get newest data
    func updateHabitData() {
        if let habit = HabitStorage.shared.fetchEntityWithId(habit.id) {
            self.habit = habit
            self.title = habit.title
            self.startTime = habit.startTime
            self.startLabel = habit.startLabel
            self.finishTime = habit.finishTime
            self.finishLabel = habit.finishLabel
            self.startTimeMode = habit.startTimeMode
            self.sortOption = SortOption(rawValue: habit.sortBy) ?? .manual
            self.sortOrder = habit.isAscending ? .ascend : .descend
            
            let actions = ActionStorage.shared.fetchActionDatas(habit: habit)
            self.actions = actions
        }
    }
    
    // MARK: - Subscribers
    func addActivitiesSubscriber() {
        $actions.map { action in
            let duration = self.actions.filter { $0.isOn }.reduce(0,{ $0 + $1.duration })
            return duration
        }
        .receive(on: DispatchQueue.main)
        .sink {[weak self] returnedValue in
            guard let self = self else { return }
            self.duration = returnedValue
            seperateMode = returnedValue > 3600
        }.store(in: cancelBag)
    }

    func addDurationSubscriber() {
        $duration.combineLatest($startTime, $startTimeMode)
            .receive(on: DispatchQueue.main)
            .sink {[weak self] (duration, startTime, startTimeMode) in
                self?.updateCalculateTime(startTime: startTime, duration: duration, startTimeMode: startTimeMode)
            }.store(in: cancelBag)
    }
    
    func updateCalculateTime(startTime: Date, duration: TimeInterval, startTimeMode: Bool) {
        var dateFormmater: DateFormatter {
            let formatter = DateFormatter()
            formatter.dateStyle = .none
            formatter.timeStyle = .short
            return formatter
        }
        finishTime = startTime.addingTimeInterval(duration)
    }

    // MARK: - Change Switch Mode
    func switchButtonTapped() {
//        guard let existCalculatedTime = finishTime.convertToDate() else { return }
//        startTime = existCalculatedTime
//        startTimeMode.toggle()
//        
//        let existCalculatedLabel = finishLabel
//        let existStandardLabel = startLabel
//        
//        startLabel = existCalculatedLabel
//        finishLabel = existStandardLabel
    }
    
    // MARK: - CRUD
    func backButtonTapped() {
        HabitStorage.shared.updateDetail(habit: habit,
                                         startLabel: startLabel,
                                         startTime: startTime,
                                         finishLabel: finishLabel,
                                         finishTime: finishTime,
                                         startTimeMode: startTimeMode,
                                         sortBy: sortOption.rawValue,
                                         isAscending: sortOrder == .ascend)
        
        for (index, action) in actions.enumerated() {
            ActionStorage.shared.update(withId: action.id, isOn: action.isOn, order: Int64(index))
        }
    }

    func deleteItem(indexSet: IndexSet) {
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
        
       
    // MARK: - Sortings
    func updateToggleState(item: Action) {
        sortActionList()
    }
    
    func updateSortOption(_ newOption: SortOption) {
        self.sortOption = newOption
        actions = getSortedList(newOption, sortOrder)
    }
    
    func updateSortOrder(_ newOrder: SortOrder) {
        self.sortOrder = newOrder
        actions = getSortedList(sortOption, newOrder)
    }
    
    func sortActionList() {
        let newList = getSortedList(sortOption, sortOrder)
        actions = newList
    }
    
    func getSortedList(_ sortOption: SortOption,_ sortOrder: SortOrder ) -> [Action] {
        var list = actions
        switch sortOption {
        case .manual:
            list = list.sorted { $0.order < $1.order }
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
