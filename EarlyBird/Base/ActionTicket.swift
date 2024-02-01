//
//  ActionTicket.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 1/2/2024.
//

import SwiftUI

struct ActionTicket: View {
    @ObservedObject var vm: NewActionListViewModel
    var habit: Habit = Habit.example
    
    init(vm: NewActionListViewModel) {
        self.vm = vm
    }

    var padding: CGFloat = .largeSize
    
    var width: CGFloat {
        return UIScreen.main.bounds.width - padding
    }
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                Text(vm.title)
                    .font(.system(size: 14, weight: .semibold, design: .default))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.leading, .regularSize)
            .padding(.vertical, .miniSize)
            .background(Color.accentColor)
            HStack(spacing: 0) {
                if vm.startTimeMode {
                    TicketTime(label: vm.standardLabel, timeLabel: vm.standardTime.convertToString(), size: width * 0.35)
                } else {
                    TicketTime(label: vm.calculatedLabel, timeLabel: vm.calculatedTime, size: width * 0.35)
                }
                Spacer()
             
                    VStack(spacing: .miniSize) {
                        VStack {
                            Text(vm.duration.getString())
                                .font(.caption)
                            LongArrow()
                                .stroke(Color.accentColor, lineWidth: 1)
                                .frame(width: UIScreen.main.bounds.width * 0.17, height: 3)
                        }
                        Circle()
                            .opacity(0)
                            .frame(height: 30)
                    }.foregroundColor(.accentColor)
                
                
                Spacer()
                if habit.startTimeMode {
                    TicketTime(label: vm.calculatedLabel, timeLabel: vm.calculatedTime, size: width * 0.35)
                } else {
                    TicketTime(label: vm.standardLabel, timeLabel: vm.standardTime.convertToString(), size: width * 0.35)
                }
            }
            .padding(.regularSize)
        }
        .background(.white)
        .frame(maxWidth: .infinity)
        .cornerRadius(12)
        .shadow(radius: 5)
    }
}

#Preview {
    ActionTicket(vm: NewActionListViewModel.init(habit: Habit.example))
}
