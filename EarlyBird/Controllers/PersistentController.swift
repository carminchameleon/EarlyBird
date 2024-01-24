//
//  PersistentController.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 30/12/2023.
//

import Foundation
import CoreData

protocol PersistenceControllerProtocol {
    
}

struct SimulatorPersistenceController: PersistenceControllerProtocol {
    static let shared = SimulatorPersistenceController()
}

struct PersistenceController: PersistenceControllerProtocol {
    // A singleton for our entire app to use
    static let shared = PersistenceController()

    // Storage for Core Data
    let container: NSPersistentContainer

    // A test configuration for SwiftUI previews
    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        let context = controller.container.viewContext        

        // Create 10 example programming languages.
        for _ in 0..<10 {
            let habit = Habit(context: context)
            habit.id = UUID()
            habit.title = "Weekly Routine"
            habit.startTime = Date()
            habit.startLabel = "✅ End Time"
            habit.finishTime = Date()
            habit.finishLabel =  "⏰ Wake Up"
            habit.startTimeMode = false
        }

        do {
            try context.save()
        } catch {
            print("Error to make preview Data")
        }
        return controller
    }()

    // An initializer to load Core Data, optionally able
    // to use an in-memory store.
    init(inMemory: Bool = false) {
        // If you didn't name your model Main you'll need
        // to change this name below.
        container = NSPersistentContainer(name: "EarlyBird")

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func save() {
        let context = container.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch let error {
                print("Error saving Core Data. \(error.localizedDescription)")
            }
        }
    }
}
