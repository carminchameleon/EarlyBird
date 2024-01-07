//
//  CycleTime.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 7/1/2024.
//

import SwiftUI

struct CycleTime {
    
    let number: Int

    var label: String {
        if number == 0 {
            return "No break"
        }
        return String(number) + "min"
    }
    var time: TimeInterval {
        TimeInterval(number * 60)
    }
    
    init(_ number: Int) {
        self.number = number
    }
}
