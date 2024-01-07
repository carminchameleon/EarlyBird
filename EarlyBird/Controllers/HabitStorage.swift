//
//  HabitStorage.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 30/12/2023.
//

import Foundation
import Combine
import CoreData
import UIKit

class HabitStorage: NSObject, ObservableObject {
    var habits = CurrentValueSubject<[Habit], Never>([])
    private let habitFetchController: NSFetchedResultsController<Habit>
    
    var persistenceController = PersistenceController.shared
    
    // Singleton Instance
    static let shared: HabitStorage = HabitStorage()
    
    // initilize controller
    private override init() {
        
        let fetchRequest: NSFetchRequest<Habit> = Habit.fetchRequest()
        fetchRequest.sortDescriptors = []
        habitFetchController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                          managedObjectContext: PersistenceController.shared.container.viewContext,
                                                          sectionNameKeyPath: nil, cacheName: nil)
    
        super.init()
    
        habitFetchController.delegate = self
        
        do {
            try habitFetchController.performFetch()
            habits.value = habitFetchController.fetchedObjects ?? []
        } catch {
            NSLog("Error: Could not fetch habit object")
        }
    }
    
    // pass only relative make new habits
    func add(title: String, startLabel: String, startTime: Date, finishLabel: String, finishTime: Date, startTimeMode: Bool) {
        let newHabit = Habit(context: persistenceController.container.viewContext)
        newHabit.id = UUID()
        newHabit.title = title
        newHabit.startLabel = startLabel
        newHabit.startTime = startTime
        newHabit.finishLabel =  finishLabel
        newHabit.finishTime = finishTime
        newHabit.startTimeMode = startTimeMode
        newHabit.sortBy = SortOption.manual.rawValue
        newHabit.isAscending = true
        persistenceController.save()
    }
        
    
    // update from detail view
    func update(withId id: UUID, title: String, startLabel: String, startTime: Date, finishLabel: String, finishTime: Date, startTimeMode: Bool) {
        if let habit = fetchEntityWithId(id) {
            habit.title = title
            habit.startLabel = startLabel
            habit.startTime = startTime
            habit.finishLabel =  finishLabel
            habit.finishTime = finishTime
            habit.startTimeMode = startTimeMode
            
            persistenceController.save()
        } else {
            print("fail to update data")
        }
    }
    
    func updateDetail(habit: Habit, startLabel: String? = nil, startTime: Date? = nil, finishLabel: String? = nil, finishTime: Date? = nil, startTimeMode: Bool? = nil, sortBy: String? = nil, isAscending: Bool? = nil) {
        
        if let startLabel = startLabel {
            habit.startLabel = startLabel
        }
        if let startTime = startTime {
            habit.startTime = startTime
        }

        if let finishLabel = finishLabel {
            habit.finishLabel = finishLabel
        }
        
        if let finishTime = finishTime {
            habit.finishTime = finishTime
        }

        if let startTimeMode = startTimeMode {
            habit.startTimeMode = startTimeMode
        }

        if let sortBy = sortBy {
            habit.sortBy = sortBy
        }
        
        if let isAscending = isAscending {
            habit.isAscending = isAscending
        }
        
        persistenceController.save()
    }
        
    func delete(withId id: UUID) {
        if let habit = fetchEntityWithId(id) {
            persistenceController.container.viewContext.delete(habit)
            persistenceController.save()
        } else {
            print("fail to delete data")
        }
    }
    
    func fetchEntityWithId(_ id: UUID) -> Habit? {
        let fetchRequest: NSFetchRequest<Habit> = Habit.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id_ == %@", id as CVarArg)
        fetchRequest.sortDescriptors = []
        do {
            let entities = try persistenceController.container.viewContext.fetch(fetchRequest)
            return entities.first
        } catch {
            let nsError = error as NSError
            fatalError("Unresolve error \(nsError), \(nsError.userInfo)")
        }
    }
}

extension HabitStorage: NSFetchedResultsControllerDelegate {
    @MainActor
    public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let habits = controller.fetchedObjects as? [Habit] else { return }
        self.habits.value = habits
    }
}
