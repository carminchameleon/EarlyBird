//
//  RoutineRepositoryInterface.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 24/1/2024.
//

import Foundation

// 루틴을 가져오는 것
protocol RoutineRepositoryInterface {
    func fetchRoutines() async throws -> [RoutineEntity]
}

struct RoutineRepository: RoutineRepositoryInterface {
    func fetchRoutines() async throws -> [RoutineEntity] {
        
    }
    
    
}
