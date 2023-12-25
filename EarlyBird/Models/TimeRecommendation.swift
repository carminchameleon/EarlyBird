//
//  TimeRecommendation.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 23/12/2023.
//

import Foundation

struct SelectableTime:Identifiable {
    var id = UUID().uuidString
//    var label: String {
//        return "\(number)\(type)"
//    }
    var type: UnitsOfTime
    
    var number: Int
}

