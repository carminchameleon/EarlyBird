//
//  ListViewModel.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 25/11/2023.
//

import Foundation

class ListViewModel: ObservableObject {
    @Published var activities: [Activity] = [] {
        didSet {
            let duration = activities.reduce(0, { $0 + $1.duration })
//            self.duration = durationㅔ메므ㅐ
        }
    }
    @Published var duration: String = "8:00 AM"
    
    
//    @Published var standardTime = "8:00 AM"
//    @Published var finiishedTime: String

    
  
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
    
    init() {
        getActivities()
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
