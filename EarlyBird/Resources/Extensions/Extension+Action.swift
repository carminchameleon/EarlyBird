//
//  Extension+Action.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 30/12/2023.
//

import Foundation

extension Action {
    public var id: UUID {
        get { id_ ?? UUID() }
        set { id_ = newValue }
    }
    
    var title: String {
        get { title_ ?? "" }
        set { title_ = newValue }
    }

    static var example: Action {
        let context = PersistenceController.preview.container.viewContext
        let action = Action(context: context)
        action.title = "YOGA"
        action.duration = 500
        action.id = UUID()
        action.order = 1
        action.isOn = true

        return action
    }
    
    
}
