//
//  RoutineUseCase.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 24/1/2024.
//

import Foundation
import CoreData
import Combine

final class RoutineUseCase {
    let repository: RoutineRepositoryInterface
    
    // 주입을 해주는 것
    init(repository: RoutineRepositoryInterface) {
        self.repository = repository
    }
    
    func fetchRoutines() -> [RoutineEntity] {
        let request: NSFetchRequest<Habit> = Habit.fetchRequest()
        
        do {
            let result = try PersistenceController.shared.container.viewContext
        } catch {
            return []
        }
    }
}
