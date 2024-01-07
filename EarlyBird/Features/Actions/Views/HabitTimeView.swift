//
//  HabitTimeView.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 6/1/2024.
//

import SwiftUI

struct HabitTimeView: View {
    @ObservedObject var vm: ActionListViewModel
    
    init(vm: ActionListViewModel) {
        self.vm = vm
    }
    
    var body: some View {
        VStack(alignment: .trailing, spacing: .smallSize) {
            VStack(alignment: .center, spacing: .smallSize) {
                Text("\(vm.startLabel) - \(vm.finishLabel)")
                    .font(.headline)
                    .bold()
                HStack {
                    Text("\(vm.startTime.convertToString())")
                        .font(.title2)
                        .fontDesign(.serif)
                        .bold()
                    Image(systemName:"arrow.right")
                        .font(.caption)
                        .foregroundColor(Theme.detailText)
                    Text("\(vm.finishTime.convertToString())")
                        .font(.title2)
                        .fontDesign(.serif)
                        .bold()
                }
            }
            .padding(.largeSize)
            .frame(maxWidth: .infinity, alignment: .center)
            .background(.ultraThickMaterial, in: RoundedRectangle(cornerRadius: .regularSize))
            
            if let actions = vm.habit.actions?.allObjects as? [Action] {
                let duration = actions.filter { $0.isOn }.reduce(0,{ $0 + $1.duration }).getString()
                if duration != "0" {
                    HStack {
                        Image(systemName: "hourglass.circle.fill")

                        Text(duration)
                    }
                    .foregroundStyle(Theme.detailText)
                    .font(.callout)
                    .bold()
                }
            }
        }.padding(.top, .regularSize)
    }
}
