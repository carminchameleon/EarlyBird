//
//  RoutineViewModel.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 29/12/2023.
//

import Foundation
import CoreData

class RoutinesViewModel: NSObject, ObservableObject {
//    private (set) var context: NSManagedObjectContext
    private let fetchResultsController: NSFetchedResultsController<RoutineEntity>
    let manager = CoreDataManager.instance
    
    @Published var routines: [RoutineEntity] = [] {
        didSet {
            print(routines)
        }
    }
    
    override init() {
        let request = RoutineEntity.fetchRequest()
        request.sortDescriptors = []
        fetchResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: manager.context, sectionNameKeyPath: nil, cacheName: nil)
        super.init()
        fetchResultsController.delegate = self
        getRoutines()
    }
     
    // Read
    func getRoutines() {
        let request = NSFetchRequest<RoutineEntity>(entityName: .routineEntity)

        do {
            let routines = try manager.context.fetch(request)
            self.routines = routines
            print(routines)
        } catch let error {
            print("fail to fetch routine, \(error.localizedDescription)")
        }
    }
    
    func addRoutine() {
        
    }
    
    
}

// whenever routine data is updated
extension RoutinesViewModel: NSFetchedResultsControllerDelegate {
    
    @MainActor
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let routines = controller.fetchedObjects as? [RoutineEntity] else {
            return
        }
        print("neeed to update routines")
        self.routines = routines
    }
}
