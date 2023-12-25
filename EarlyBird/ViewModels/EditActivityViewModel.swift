//
//  EditActivityViewModel.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 24/12/2023.
//

import Foundation

class EditActivityViewModel: ObservableObject {
    @Published var item: Activity?
    
    @Published var textFieldValue: String = ""
    
    @Published var hours: Int = 00
    
    @Published var mins: Int = 00
    
    @Published var isOn = true
    
    var updateActivity: (Activity) -> Void
    
    init(item: Activity?, updateActivity: @escaping ((Activity)-> Void)) {
        self.item = item
        self.textFieldValue = item?.title ?? ""
        self.hours = item?.duration.getTime().hours ?? 0
        self.mins = item?.duration.getTime().minutes ?? 0
        self.isOn = item?.isOn ?? true
        self.updateActivity = updateActivity
    }
    
    func handleSaveButtonTapped() {
        let title = textFieldValue.trimmingCharacters(in: .whitespaces)
        let duration = Double(hours * 3600 + mins * 60)
        item = item?.updateActivity(newTitle: title, newDuration: duration, isOn: isOn)
        if let item = item {
            updateActivity(item)
        }
    }
}
