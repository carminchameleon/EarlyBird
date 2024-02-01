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
    
    var timeSet: ActionTimelineSet {
        return getActionTime()
    }
    
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
        self.standardTime = habit.standardTime
        self.standardLabel = habit.standardLabel
        self.calculatedTime = habit.calculatedTime
        self.calculatedLabel = habit.calculatedLabel
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
            self.standardTime = habit.standardTime
            self.standardLabel = habit.standardLabel
            self.calculatedTime = habit.calculatedTime
            self.calculatedLabel = habit.calculatedLabel
            self.startTimeMode = habit.startTimeMode
            self.sortOption = SortOption(rawValue: habit.sortBy) ?? .manual
            self.sortOrder = habit.isAscending ? .ascend : .descend
            
            let actions = ActionStorage.shared.fetchActionDatas(habit: habit)
            self.actions = actions
        }
    }
    typealias ActionTimelineSet = [UUID : (startDate: Date?, endDate: Date?)]
    
    func getActionTime() -> ActionTimelineSet {
        let sorted = actions.sorted{ $0.order > $1.order }
        let actionTimesWithId = calculateActionTimesWithId(actions: sorted, standardTime: standardTime)
        
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        for (actionId, times) in actionTimesWithId {
            let startTimeStr = times.startDate != nil ? formatter.string(from: times.startDate!) : "빈 값"
            let endTimeStr = times.endDate != nil ? formatter.string(from: times.endDate!) : "빈 값"
            print("Action ID \(actionId): 시작 \(startTimeStr), 종료 \(endTimeStr)")
        }
        return actionTimesWithId
    }
    
    func calculateActionTimesWithId(actions: [Action], standardTime: Date) -> [UUID: (startDate: Date?, endDate: Date?)] {
        var results = [UUID: (startDate: Date?, endDate: Date?)]()
        var currentTime = standardTime

        for action in actions {
            if action.isOn {
                let startTime = currentTime
                let endTime = startTime.addingTimeInterval(habit.startTimeMode ? TimeInterval(action.duration) : -TimeInterval(action.duration)) // 분을 초로 변환
                results[action.id] = (startDate: startTime, endDate: endTime)
                currentTime = endTime
            } else {
                // isOn이 false인 경우, 딕셔너리에 빈 값으로 설정
                results[action.id] = (startDate: nil, endDate: nil)
                currentTime = currentTime.addingTimeInterval(habit.startTimeMode ? TimeInterval(action.duration) : -TimeInterval(action.duration))
            }
        }

        return results
    }
    
    // MARK: - Subscribers
    func addActivitiesSubscriber() {
        $actions
            .map { action in
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

    // MARK: - Change Switch Mode
    func switchButtonTapped() {
        guard let existCalculatedTime = calculatedTime.convertToDate() else { return }
        standardTime = existCalculatedTime
        startTimeMode.toggle()
        
        let existCalculatedLabel = calculatedLabel
        let existStandardLabel = standardLabel
        
        standardLabel = existCalculatedLabel
        calculatedLabel = existStandardLabel
    }
    
    // MARK: - CRUD
    func backButtonTapped() {
        HabitStorage.shared.updateDetail(habit: habit,
                                         standardLabel: standardLabel,
                                         standardTime: standardTime,
                                         calculatedLabel: calculatedLabel,
                                         calculatedTime: calculatedTime,
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
    
    func deleteItem(id: UUID) {
        ActionStorage.shared.delete(withId: id)
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
        updateActionsOrder()
    }
    
    func updateSortOrder(_ newOrder: SortOrder) {
        self.sortOrder = newOrder
        actions = getSortedList(sortOption, newOrder)
        updateActionsOrder()
    }
    

    func sortActionList() {
        let newList = getSortedList(sortOption, sortOrder)
        actions = newList
        updateActionsOrder()
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
    
    
    func updateActionsOrder() {
        for (index, action) in actions.enumerated() {
            action.order = Int64(index)
        }
    }
}

