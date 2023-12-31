//
//  EarlyBirdApp.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 25/11/2023.
//

import SwiftUI

@main
struct EarlyBirdApp: App {
    @StateObject var listViewModel = RoutineListViewModel()
    let persistenceController = PersistenceController.shared

    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
//                ListView()
//                RoutineListView()
                HabitListView()
            }
        }.environmentObject(listViewModel)
    }
}
