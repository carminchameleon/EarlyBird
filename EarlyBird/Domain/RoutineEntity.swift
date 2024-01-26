//
//  HabitEntity.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 24/1/2024.
//

import Foundation

// 앱에서 가장 핵심이 되는 엔터티. 변하지 않는 객체.
struct RoutineEntity {
    let id: UUID
    let title: String
    var standardLabel: String
    var standardTime: Date
    var calculatedLabel: String
    var calculatedTime: String
    var startTimeMode = true
}
