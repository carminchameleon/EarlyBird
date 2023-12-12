//
//  Extensions+TimeInterval.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 25/11/2023.
//

import Foundation

extension TimeInterval {
    /**
    Change time interval to string
    >   Change time interval to string HR, MIN, SEC
    - Parameters:
        - timeInterval: time interval
    */
    func getString() -> String {
            let hours = Int(self) / 3600
            let minutes = (Int(self) % 3600) / 60
            let seconds = Int(self) % 60
            
            var components: [String] = []
            
            if hours > 0 {
                components.append("\(hours)\(Time.hours.rawValue)")
            }
            if minutes > 0 {
                components.append("\(minutes)\(Time.minutes.rawValue)")
            }
            if seconds > 0 {
                components.append("\(seconds)\(Time.seconds.rawValue)")
            }
            
            return components.joined(separator: " ")
        }
}
