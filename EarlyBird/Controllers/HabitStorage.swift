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
    func add(title: String, standardLabel: String, standardTime: Date, calculatedLabel: String, startTimeMode: Bool, color: UIColor) {
        let newHabit = Habit(context: persistenceController.container.viewContext)
        newHabit.id = UUID()
        newHabit.title = title
        newHabit.standardLabel = standardLabel
        newHabit.standardTime = standardTime
        newHabit.calculatedLabel =  calculatedLabel
        newHabit.calculatedTime = "" // default
        newHabit.color = color // "#0000ff"
        newHabit.startTimeMode = startTimeMode
        newHabit.duration = 0 // default
        
        persistenceController.save()
    }
        
    
    // update from detail view
    func update(withId id: UUID, title: String, standardLabel: String, standardTime: Date, calculatedLabel: String, startTimeMode: Bool, color: UIColor) {
        if let habit = fetchEntityWithId(id) {
            habit.title = title
            habit.standardLabel = standardLabel
            habit.standardTime = standardTime
            habit.calculatedLabel =  calculatedLabel
            habit.color = color // "#0000ff"
            habit.startTimeMode = startTimeMode
            
            persistenceController.save()
        } else {
            print("fail to update data")
        }
    }
        
    func delete(withId id: UUID) {
        if let habit = fetchEntityWithId(id) {
            persistenceController.container.viewContext.delete(habit)
            persistenceController.save()
        } else {
            print("fail to delete data")
        }
            
    }
    
    private func fetchEntityWithId(_ id: UUID) -> Habit? {
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
