//
//  ListViewModel.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 25/11/2023.
//

import Foundation

class ListViewModel: ObservableObject {
    @Published var activities: [Activity] = []

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
