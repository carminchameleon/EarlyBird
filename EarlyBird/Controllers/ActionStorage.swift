//
//  ActionStorage.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 31/12/2023.
//

import Foundation
import Combine
import CoreData
import UIKit

class ActionStorage: NSObject, ObservableObject {
    var Actions = CurrentValueSubject<[Action], Never>([])
    private let actionFetchController: NSFetchedResultsController<Action>
    
    var persistenceController = PersistenceController.shared
    
    // Singleton Instance
    static let shared: ActionStorage = ActionStorage()
    
    // initilize controller
    private override init() {
        
        let fetchRequest: NSFetchRequest<Action> = Action.fetchRequest()
        fetchRequest.sortDescriptors = []
        actionFetchController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                          managedObjectContext: PersistenceController.shared.container.viewContext,
                                                          sectionNameKeyPath: nil, cacheName: nil)
    
        super.init()
        
        actionFetchController.delegate = self
        
        do {
            try actionFetchController.performFetch()
            Actions.value = actionFetchController.fetchedObjects ?? []
        } catch {
            NSLog("Error: Could not fetch Action object")
        }
    }
    
    // pass only relative make new Actions
    func add(title: String, duration: Double, isOn: Bool, habit: Habit) {
        let newAction = Action(context: persistenceController.container.viewContext)
        newAction.id = UUID()
        newAction.title = title
        newAction.duration = duration
        newAction.isOn = true
        newAction.habit = habit
        persistenceController.save()
    }
        
    
    // update from detail view
    func update(withId id: UUID, title: String, duration: Double, isOn: Bool, habit: Habit) {
        if let action = fetchEntityWithId(id) {
            action.id = id
            action.title = title
            action.duration = duration
            action.isOn = isOn
            action.habit = habit
            
            persistenceController.save()
        } else {
            print("fail to update data")
        }
    }
        
    func delete(withId id: UUID) {
        if let action = fetchEntityWithId(id) {
            persistenceController.container.viewContext.delete(action)
            persistenceController.save()
        } else {
            print("fail to delete data")
        }
            
    }
    
    private func fetchEntityWithId(_ id: UUID) -> Action? {
        let fetchRequest: NSFetchRequest<Action> = Action.fetchRequest()
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

extension ActionStorage: NSFetchedResultsControllerDelegate {
    @MainActor
    public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let Actions = controller.fetchedObjects as? [Action] else { return }
        self.Actions.value = Actions
    }
}
