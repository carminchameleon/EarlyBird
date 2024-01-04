//
//  TimelineController.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 1/1/2024.
//

import SwiftUI

struct TimelineController: View {
    @ObservedObject var vm: ActionListViewModel
    
    var body: some View {
        if vm.standardLabel.count >  10 || vm.duration > 3600 {
            VStack(alignment: .leading) {
                HStack {
                    Text(vm.startTimeMode ? "🚀": "🏁" )
                    Text(vm.standardLabel)
                        .font(.callout)
                        .fontDesign(.serif)
                        .tint(Theme.detailText)
                        .bold()
                        .scaledToFit()
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
                    
                    Spacer()
                 
                    DatePicker("",selection: $vm.standardTime, displayedComponents: .hourAndMinute)
                        .datePickerStyle(CompactDatePickerStyle())
                        .clipped()
                        .labelsHidden()
                }
                HStack {
                   duration
                }
            }
        } else {
            HStack {
                duration
                Spacer()
                
                Text(vm.startTimeMode ? "🚀": "🏁" )
                Text(vm.standardLabel)
                DatePicker("",selection: $vm.standardTime, displayedComponents: .hourAndMinute)
                    .datePickerStyle(CompactDatePickerStyle())
                    .clipped()
                    .labelsHidden()
            }
        }
    }
    
    var duration: some View {
        Group {
            Text("⏳")
            Text(vm.duration.getString())
                .font(.callout)
                .fontDesign(.serif)
                .bold()

        }
    }
}
