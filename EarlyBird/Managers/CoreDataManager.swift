//
//  CoreDataManager.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 29/12/2023.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let instance = CoreDataManager()
    
    let container: NSPersistentContainer
    
    let context: NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "EarlyBirdContainer")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("ERROR LOADING CORE DATA \(error)")
            } else {
                print("✅ Successfully init Core Data")
            }
        }
        context = container.viewContext
    }
    
    func saveContext() {
        let context = container.viewContext

            if context.hasChanges {
                do {
                    try context.save()
                    print("✅ Successfully saved at CoreData")
                } catch let error {
                    print("Error saving Core Data", error.localizedDescription)
                }
            }
    }
}
