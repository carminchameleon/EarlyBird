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
    
    
}
