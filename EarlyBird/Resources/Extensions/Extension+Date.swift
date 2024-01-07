//
//  Extension+Date.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 12/12/2023.
//

import Foundation

extension Date {
    
    func convertToString() -> String {
        
        var dateFormmater: DateFormatter {
            let formatter = DateFormatter()
            formatter.dateStyle = .none
            formatter.timeStyle = .short
            return formatter
        }
        
        return dateFormmater.string(from: self)
    }
    
    func convertToSimpleString() -> String {
        var dateFormmater: DateFormatter {
            let formatter = DateFormatter()
            formatter.dateStyle = .none
            formatter.timeStyle = .short
            return formatter
        }
        
        let time = dateFormmater.string(from: self)
        let endIndex = time.index(time.endIndex, offsetBy: -2)
        let truncated = time.substring(to: endIndex)
        return truncated
    }
    
    func convertToTimeState() -> String {
        var dateFormmater: DateFormatter {
            let formatter = DateFormatter()
            formatter.dateStyle = .none
            formatter.timeStyle = .short
            return formatter
        }
        
        let time = dateFormmater.string(from: self)
        let last = String(time.suffix(2))
        return last
    }
    
    
    
    
}
