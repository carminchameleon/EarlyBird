//
//  ListViewModel.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 25/11/2023.
//

import Foundation
import Combine

class ActivityListViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var activities: [Activity] = []
    
    @Published var standardTime = Date()
    @Published var standardLabel = "✅ End Time"
    
    @Published var calculatedTime = ""
    @Published var calculatedLabel = "⏰ Wake Up"
    
    @Published var startTimeMode: Bool = false
    
    var sortOption = SortOption.manual

    var sortOrder = SortOrder.ascend

    
    @Published var selectedItem: Activity? = nil
    @Published var duration: TimeInterval = 0

    
    var cancelBag = CancelBag()
    
    init(routine: Routine) {
        self.title = routine.title
        self.standardTime = routine.standardTime
        self.standardLabel = routine.standardLabel
        self.calculatedTime = routine.calculatedTime
        self.calculatedLabel = routine.calculatedLabel
        self.startTimeMode = routine.startTimeMode
        self.activities = routine.activities
        
        addActivitiesSubscriber()
        addDurationSubscriber()
    }
    
    func getActivities() {
        let initialList: [Activity] = [
            
            Activity(title: "A _ Yoga", duration: 1200),
            Activity(title: "B - Drink Hot Water", duration: 60),
            Activity(title: "C _ Organize bed", duration: 90),
            Activity(title: "D _ Morning Page", duration: 2400),
        ]
        activities.append(contentsOf: initialList)
    }
    
    
    func addActivitiesSubscriber() {
        $activities.map { activities in
            // activities 리스트를 전체 다 받을 예정임
            let duration = activities.filter { $0.isOn }.reduce(0,{ $0 + $1.duration })
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
    

    /**
    1. activity에 따라서 duration을 바꾼다.
     2. duration에 따라서 예상 시간을 바꾼다.
     */
    
    /**
     만약 끝나는 시간이 기준이면
     끝나는 시간 - 소요시간 = 시작 시간
     
     만약 시작 시간이 기준이라면
     시작 시간 + 소요시간 = 끝나는 시간
     */
    // 기준인 시간은 선택해서 바꿀 수 있다. 
    
    func deleteItem(indexSet: IndexSet) {
        activities.remove(atOffsets: indexSet)
    }
    
    func moveItem(from: IndexSet, to: Int) {
        sortOption = .manual
        sortOrder = .ascend
        activities.move(fromOffsets: from, toOffset: to)
        
    }
        
    func updateToggleState(item: Activity){
        if let index = activities.firstIndex(where: { $0.id == item.id }) {
            activities[index] = item.updateToggle()
        }
        sortActivityList()
    }
    
    func addItem(item: Activity) {
        activities.append(item)
        sortActivityList()
    }
    
    func sortActivityList() {
        let newList = getSortedList(sortOption, sortOrder)
        activities = newList
    }
    
    func updateActivity(item: Activity) {
        if let index = activities.firstIndex(where: {  $0.id == item.id  }) {
            activities[index] = item
        }
        sortActivityList()
    }
    
    // change standard time
    func switchButtonTapped() {
        guard let existCalculatedTime = calculatedTime.convertToDate() else { return }
        standardTime = existCalculatedTime
        startTimeMode.toggle()
        
        let existCalculatedLabel = calculatedLabel
        let existStandardLabel = standardLabel
        
        standardLabel = existCalculatedLabel
        calculatedLabel = existStandardLabel
    }
    
    func updateSortOption(_ newOption: SortOption) {
        self.sortOption = newOption
        activities = getSortedList(newOption, sortOrder)
    }
    
    func updateSortOrder(_ newOrder: SortOrder) {
        self.sortOrder = newOrder
        activities = getSortedList(sortOption, newOrder)
    }
    
    
    func getSortedList(_ sortOption: SortOption,_ sortOrder: SortOrder ) -> [Activity] {
        var list = activities
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
