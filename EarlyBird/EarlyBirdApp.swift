//
//  EarlyBirdApp.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 25/11/2023.
//

import SwiftUI

@main
struct EarlyBirdApp: App {
    let persistenceController: PersistenceControllerProtocol = SimulatorPersistenceController.shared

    var body: some Scene {
        WindowGroup {
            NavigationStack {
//                HabitListView()
                RoutineListView()
            }
        }
    }
}
