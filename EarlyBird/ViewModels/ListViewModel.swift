//
//  ListViewModel.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 25/11/2023.
//

import Foundation
import Combine

class ListViewModel: ObservableObject {
    @Published var activities: [Activity] = []
    @Published var endPoint = Date()
    @Published var duration: TimeInterval = 0
    @Published var isAdd: Bool = false
    @Published var calculatedTime = ""
    var cancellables: Set<AnyCancellable> = []

    init() {
        getActivities()
        addActivitiesSubscriber()
        addDurationSubscriber()
        addEndPointSubscriber()
    }
    
    func getActivities() {
        let initialList: [Activity] = [
            Activity(title: "Drink Hot Water", duration: 60),
            Activity(title: "Organize bed", duration: 60),
            Activity(title: "Yoga", duration: 2400),
            Activity(title: "Morning Page", duration: 2400),
        ]
        activities.append(contentsOf: initialList)
    }
    
    // activity에 따라서 duration을 업데이트
    
    func addActivitiesSubscriber() {
        $activities.map { activities in
            // activities 리스트를 전체 다 받을 예정임
            let duration = activities.filter { $0.isOn }.reduce(0,{ $0 + $1.duration })
            print(duration)
            return duration
        }.sink {[weak self] returnedValue in
            guard let self = self else { return }
            self.duration = returnedValue
        }.store(in: &cancellables)
    }
    
    func addDurationSubscriber() {
        $duration.combineLatest($endPoint, $isAdd)
            .receive(on: DispatchQueue.main)
            .sink {[weak self] (duration, endpoint, isAdd) in
                self?.updateCalculateTime(endPoint: endpoint, duration: duration, isAdd: isAdd)
            }.store(in: &cancellables)
    }
    
    func addEndPointSubscriber() {
        $endPoint.combineLatest($duration, $isAdd)
            .receive(on: DispatchQueue.main)
            .sink {[weak self] (endPoint, duration, isAdd) in
                self?.updateCalculateTime(endPoint: endPoint, duration: duration, isAdd: isAdd)
            }.store(in: &cancellables)
    }
    
    func updateCalculateTime(endPoint: Date, duration: TimeInterval, isAdd: Bool) {
        var dateFormmater: DateFormatter {
            let formatter = DateFormatter()
            formatter.dateStyle = .none
            formatter.timeStyle = .short
            return formatter
        }
        
        let resultDate = endPoint.addingTimeInterval( isAdd ? duration : -duration )
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
        activities.move(fromOffsets: from, toOffset: to)
    }
    
    func updateItem(indexSet: IndexSet){
        
    }
    
    func updateToggleState(item: Activity){
        if let index = activities.firstIndex(where: { $0.id == item.id }) {
            activities[index] = item.updateToggle()
        }
    }
    
    
    func addItem(item: Activity) {
       
    }
    
    // update activity data
}
