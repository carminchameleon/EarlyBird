//
//  ListViewModel.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 25/11/2023.
//

import Foundation
import Combine

class ListViewModel: ObservableObject {
    @Published var activities: [Activity] = [] {
        didSet {
            print(activities)
        }
    }
    @Published var standardTime = "8:00 am"
    
    @Published var endPoint = Date()
    @Published var duration: TimeInterval = 0
    @Published var isAdd: Bool = false
    @Published var calculatedTime = ""
    var cancellables: Set<AnyCancellable> = []


    init() {
        getActivities()
//        addActivitySubscriber()
        addActivitiesSubscriber()
        addDurationSubscriber()
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
    
    func addActivitySubscriber() {
        activities
            .publisher
            .reduce(0, { $0 + $1.duration })
            .sink {[weak self] value in
                self?.duration = value
            }
            .store(in: &cancellables)
    }
    
    func addActivitiesSubscriber() {
        $activities.map { activities in
            // activities 리스트를 전체 다 받을 예정임
            let duration = activities.reduce(0,{ $0 + $1.duration })
            return duration
        }.sink {[weak self] returnedValue in
            guard let self = self else { return }
            self.duration = returnedValue
        }.store(in: &cancellables)
    }
    
    func addDurationSubscriber() {
        // 기준 시간 + 소요 시간 더해서 처리하는 것
        $duration.combineLatest($standardTime, $isAdd)
            .sink { (duration, standardTime, isAdd) in
                // duration
                // standardTime
                // isAdd
                
                // string으로 되어 있는 값을 time으로 바꾼다.
                var dateFormmater: DateFormatter {
                    let formatter = DateFormatter()
                    formatter.dateStyle = .none
                    formatter.timeStyle = .short
                    
                    return formatter
                }
                
                if let timeDate = dateFormmater.date(from: standardTime) {
                    // 8시라면 -> 8시간을 추출
                    
                    // 현재 날짜와 시간
                    let now = Date()
                    // Calendar 객체를 생성
                    let calendar = Calendar.current
                    // 현재 날짜로부터 특정 시간 후
                    guard let standardDate = calendar.date(bySettingHour: calendar.component(.hour, from: timeDate),
                                                           minute: calendar.component(.minute, from: timeDate),
                                                           second: calendar.component(.second, from: timeDate),
                                                           of: now) else { return }
                    // 몇시간 몇
                    let resultDate = standardDate.addingTimeInterval( isAdd ? duration : -duration)
                    let resultString = dateFormmater.string(from: resultDate)
                    self.calculatedTime = resultString
                }
            }.store(in: &cancellables)
        
        
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
    
    func updateItem(){
        
    }
    
    func addItem(item: Activity) {
        activities.append(item)
    }
}
