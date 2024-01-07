//
//  CycleView.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 7/1/2024.
//

import SwiftUI

////첫 번째 모드 (시작 시간과 끝 시간으로 cycle 계산):
//
//startTime: 시작 시간을 나타냅니다.
//endTime: 끝 시간을 나타냅니다.
//numberOfCycles: 계산된 cycle의 수를 저장합니다.
//calculateCycles: cycle 수를 계산하는 함수의 이름입니다.
//두 번째 모드 (시작 시간과 cycle 수로 끝 시간 계산):
//
//startTime: 시작 시간을 나타냅니다.
//cyclesToComplete: 완료할 cycle의 수를 나타냅니다.
//calculatedEndTime: 계산된 끝 시간을 저장합니다.
//calculateEndTime: 끝 시간을 계산하는 함수의 이름입니다.

struct CycleView: View {
    @StateObject var vm = CycleViewModel()
    
    var body: some View {
        List {
            Picker("", selection: $vm.endTimeMode){
                Text("End Time").tag(true)
                Text("Cycle").tag(false)
            }
            .labelsHidden()
            .pickerStyle(.segmented)

            HStack(alignment: .center) {
                Text("Time")

                Spacer()
                DatePicker("Please enter a date", selection: $vm.startTime, displayedComponents: .hourAndMinute)
                    .datePickerStyle(.compact)
                    .labelsHidden()
                Text(" - ")
                DatePicker("Please enter a date", selection: $vm.endTime, displayedComponents: .hourAndMinute)
                    .datePickerStyle(.compact)
                    .labelsHidden()
            }
            
    
            LabeledContent("Cycle") {
                Picker("", selection: $vm.sessionDuration){
                    ForEach(Array(vm.cycleList.enumerated()), id: \.offset) { (index, list) in
                        Text(list.label).tag(index)
                    }
                }
                .labelsHidden()
                .pickerStyle(.menu)
            }
                                
            
//            Section {
//                Picker("", selection: $vm.endTimeMode){
//                    Text("End Time").tag(true)
//                    Text("Cycle").tag(false)
//                }
//                .labelsHidden()
//                .pickerStyle(.segmented)
//                
//                VStack {
//                    HStack(alignment: .center) {
//                        Text("Time")
//                        
//                        Spacer()
//                        DatePicker("Please enter a date", selection: $vm.startTime, displayedComponents: .hourAndMinute)
//                            .datePickerStyle(.compact)
//                            .labelsHidden()
//                        Text(" - ")
//                        DatePicker("Please enter a date", selection: $vm.endTime, displayedComponents: .hourAndMinute)
//                            .datePickerStyle(.compact)
//                            .labelsHidden()
//                    }
//                    
//                }
//                Section {
//                    Group {
//                        LabeledContent("Cycle") {
//                            Picker("", selection: $vm.sessionDuration){
//                                ForEach(Array(vm.sessionList.enumerated()), id: \.offset) { (index, list) in
//                                    Text(list.label).tag(index)
//                                }
//                            }
//                            .labelsHidden()
//                            .pickerStyle(.menu)
//                        }
//                    }
//                    HStack {
//                        LabeledContent("Break") {
//                            Picker("", selection: $vm.breakDuration){
//                                ForEach(vm.breakList, id: \.number) { list in
//                                    Text(list.label).tag(list.number)
//                                    
//                                }
//                            }
//                            .labelsHidden()
//                            .pickerStyle(.menu)
//                        }
//                    }
//                    if vm.breakDuration != 0 {
//                        HStack {
//                            Stepper("sessions before break", value: $vm.sessionsBeforeBreak, in: 0...3)
//                        }
//
//                    }
//                }
//            }
        }
        .font(.callout)
        .fontDesign(.serif)
        .bold()
        .listStyle(.insetGrouped)
        .listSectionSpacing(.largeSize)
        .navigationTitle("Cycle Calculator")
    }
}

#Preview {
    CycleView()
}
