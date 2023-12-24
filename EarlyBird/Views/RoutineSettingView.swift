//
//  RoutineInfoView.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 24/12/2023.
//

import SwiftUI

struct RoutineSettingView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var vm: RoutineSettingViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            
            Form {
                Section {
                    TextField("Morning, Night, Weekends etc", text: $vm.title)
                        .padding(.miniSize)
                        .multilineTextAlignment(.center)
                } header: {
                    Text("Title")
                }
                Section {
                    Picker("", selection: $vm.isStartSelected.animation(.spring)) {
                        Text(TimeConfiguration.start.title).tag(0)
                        Text(TimeConfiguration.end.title).tag(1)
                    }
                    .padding(.miniSize)
                    .labelsHidden()
                    .pickerStyle(.inline)
                } header: {
                    Text("Need to know")
                }
                
                Section {
                    TextField("Morning, Night, Weekends etc", text: $vm.standardTitle)
                    DatePicker("",selection: $vm.standardTime, displayedComponents: .hourAndMinute)
                        .datePickerStyle(.wheel)
                } header: {
                    Text(vm.standardGuideTitle)

                }
                Section {
                    TextField("Morning, Night, Weekends etc", text: $vm.calculatedTitle)
                } header: {
                    Text(vm.calculatedGuideTitle)
                }
            }.formStyle(.grouped)
        }
        .navigationTitle("Routine Info")
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button(action: {
                    dismiss()
                }, label: {
                    Text("Cancel")
                })
            }
            ToolbarItem(placement: .confirmationAction) {
                Button(action: {
                    print("Save button tapped")
                }, label: {
                    Text("Save")
                })
            }

        }
    }
}

#Preview {
    RoutineSettingView(vm: RoutineSettingViewModel())
}
