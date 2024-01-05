//
//  HabitDetailView.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 30/12/2023.
//

import SwiftUI

struct HabitDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var vm: HabitDetailViewModel
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: .largeSize) {
                titleSection
                modeSection
                standardSetion
                calculatedSection
            }
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
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
                    vm.saveButtonTapped()
                    dismiss()
                }, label: {
                    Text("Save")
                }).disabled(vm.title.isEmpty || vm.startLabel.isEmpty || vm.finishLabel.isEmpty)
            }
        }
    }
    
    var titleSection: some View {
        TextField("Routine name", text: $vm.title)
            .font(.title3)
            .bold()
            .multilineTextAlignment(.center)
            .foregroundColor(Theme.pill)
            .padding(.horizontal)
            .frame(height: 55)
            .background(Color(UIColor.secondarySystemBackground))
            .cornerRadius(.smallSize)
    }
    
    var modeSection: some View {
        VStack {
            Text("Which one you want to set first?")
                .font(.callout)
                .bold()
                .fontDesign(.serif)
            
                .frame(maxWidth: .infinity, alignment: .leading)
            
            GroupBox {
                VStack(alignment: .leading) {
                    HStack(alignment: .center, spacing: .ultraLargeSize) {
              
                        VStack(spacing: .smallSize) {
                            VStack {
                                Text("🚀")
                                    .font(.largeTitle)
                                    .frame(width:120)
                                Text("Start Time")
                            }
                            .font(.caption)
                            .bold()
                            .fontDesign(.serif)
                            
                            RadioButton(value: $vm.startTimeMode) { result in
                                vm.startTimeMode = true
                            }
                        }
                        
                        VStack(spacing: .smallSize) {
                            VStack {
                                Text("🏁")
                                    .font(.largeTitle)
                                    .frame(width:120)
                                Text("Finish Time")

                            }
                            .font(.caption)
                            .bold()
                            .fontDesign(.serif)
                            RadioButton(value: .constant(vm.startTimeMode == false)) { result in
                                vm.startTimeMode = false
                            }
                            
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
    }
    
    var standardSetion: some View {
        VStack {
            Text(vm.standardGuide)
                .font(.callout)
                .bold()
                .fontDesign(.serif)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            TextField(vm.startPlaceholder, text: vm.startTimeMode ? $vm.startLabel : $vm.finishLabel)
                .font(.title3)
                .bold()
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .frame(height: 55)
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(.smallSize)
            GroupBox {
                DatePicker("",selection: vm.startTimeMode ? $vm.startTime : $vm.finishTime, displayedComponents: .hourAndMinute)
                    .frame(height: 180)
                    .datePickerStyle(.wheel)
            }
        }
    }

    var calculatedSection: some View {
        VStack {
            Text(vm.calculatedGuide)
                .font(.callout)
                .bold()
                .fontDesign(.serif)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            TextField(vm.calculatedPlaceholder, text: vm.startTimeMode ? $vm.finishLabel : $vm.startLabel)
                .font(.title3)
                .bold()
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .frame(height: 55)
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(.mediumSize)
        }
    }
    
}

#Preview {
    HabitDetailView(vm: HabitDetailViewModel())
}
