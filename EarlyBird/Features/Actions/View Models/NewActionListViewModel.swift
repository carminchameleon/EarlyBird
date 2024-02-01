//
//  NewActionListViewModel.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 1/2/2024.
//

import Foundation
import Combine

class NewActionListViewModel: ObservableObject {
    var habit: Habit
    
    @Published var title: String = ""
    
    @Published var standardTime = Date()
    
    @Published var standardLabel = "✅ End Time"
    
    @Published var calculatedTime = ""
    
    @Published var calculatedLabel = "⏰ Wake Up"
    
    @Published var startTimeMode: Bool = false
    
    @Published var actions: [Action] = []
    
    @Published var selectedItem: Action? = nil
    
    @Published var duration: TimeInterval = 0
    
    @Published var timelines = TimelineSummary()
    
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
        
        addActionSubscriber()
        addDurationSubscriber()
    }
    
    func updateHabitData() {
        if let habit = HabitStorage.shared.fetchEntityWithId(habit.id) {
            self.habit = habit
            self.title = habit.title
            self.standardTime = habit.standardTime
            self.standardLabel = habit.standardLabel
            self.calculatedTime = habit.calculatedTime
            self.calculatedLabel = habit.calculatedLabel
            self.startTimeMode = habit.startTimeMode
            
            let actions = ActionStorage.shared.fetchActionDatas(habit: habit)
            self.actions = actions
            
        }
    }
    func addActionSubscriber() {
        // action 리스트를 가지고, 합쳐서 duration으로 리턴하는 것
        $actions.compactMap { (actions: [Action]) -> Double in
            return actions.filter{ $0.isOn }.reduce(0, {$0 + $1.duration })
        }.subscribe(Subscribers.Assign(object: self, keyPath: \.duration))
        
        $actions.combineLatest($standardTime, $startTimeMode)
            .receive(on: DispatchQueue.main)
            .sink {[weak self] (actions, standardTime, startTimeMode) in
                self?.timelines = self?.getTimelines(actions, standardTime, startTimeMode) ?? [:]
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
    
    typealias TimelineSummary =  [UUID: (startDate: String, endDate: String)]
    
    
    func getTimelines(_ actions: [Action],_ standardTime: Date,_ startTimeMode: Bool) -> [UUID: (startDate: String, endDate: String)] {
        var results = [UUID: (startDate: String, endDate: String)]()
    
        var currentTime = standardTime
        
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        
//        print(actions)
        let sorted = actions.sorted{ $0.order > $1.order }
        
        for action in sorted {
//            print(action.title)
//            print(results)
            if action.isOn {
                let startTime = currentTime
                let endTime = startTime.addingTimeInterval(startTimeMode ? TimeInterval(action.duration) : -TimeInterval(action.duration)) // 분을 초로 변환
                results[action.id] = (startDate: formatter.string(from: startTime), endDate: formatter.string(from: endTime))
                currentTime = endTime
            } else {
                results[action.id] = (startDate: "", endDate: "")
                currentTime = currentTime.addingTimeInterval(startTimeMode ? TimeInterval(action.duration) : -TimeInterval(action.duration))
            }
        }
//        print(results)
        return results
    }
    
    func backButtonTapped() {
        HabitStorage.shared.updateDetail(habit: habit,
                                         standardLabel: standardLabel,
                                         standardTime: standardTime,
                                         calculatedLabel: calculatedLabel,
                                         calculatedTime: calculatedTime,
                                         startTimeMode: startTimeMode,
                                         sortBy: "Manual", // 임시
                                         isAscending: true) // 임시
        
        for (index, action) in actions.enumerated() {
            ActionStorage.shared.update(withId: action.id, isOn: action.isOn, order: Int64(index))
        }
    }
    
    func moveItem(from: IndexSet, to: Int) {
        actions.move(fromOffsets: from, toOffset: to)
        for (index, action) in actions.enumerated() {
            action.order = Int64(index)
        }
    }

    func deleteItem(id: UUID) {
        ActionStorage.shared.delete(withId: id)
    }
}
