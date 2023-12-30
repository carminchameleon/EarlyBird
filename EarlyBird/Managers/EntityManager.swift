//
//  Entities.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 29/12/2023.
//

import Foundation
import SwiftUI

extension RoutineEntity {
    public var id: UUID {
        get { id_ ?? UUID() }
        set { id_ = newValue }
    }
    
    var name: String {
        get { name_ ?? "" }
        set { name_ = newValue }
    }
    
    var standardTime: Date {
        get { standardTime_ ?? Date.now }
        set { standardTime_ = newValue }
    }
    
    var standardLabel: String {
        get { standardLabel_ ?? "" }
        set { standardLabel_ = newValue }
    }
    
    var calculatedTime: String {
        get { calculatedTime_ ?? "" }
        set { calculatedTime_ = newValue }
    }
    
    var calculatedLabel: String {
        get { calculatedLabel_ ?? "" }
        set { calculatedLabel_ = newValue }
    }
    
    var color: String {
        get { color_ ?? "#0E7AFE" }
        set { color_ = newValue }
    }
    
    var uiColor: UIColor {
        get { UIColor(hex: color) }
        set { color = newValue.colorToHex() }
    }
}
