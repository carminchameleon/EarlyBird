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
                }).disabled(vm.title.isEmpty || vm.standardLabel.isEmpty || vm.calculatedLabel.isEmpty)
            }
        }
    }
    
    var titleSection: some View {
        TextField("Routine name", text: $vm.title)
            .font(.title3)
            .bold()
            .multilineTextAlignment(.center)
            .foregroundColor(vm.color)
            .padding(.horizontal)
            .frame(height: 55)
            .background(Color(UIColor.secondarySystemBackground))
            .cornerRadius(.smallSize)
    }
    
    var modeSection: some View {
        VStack {
            Text("Need to know")
                .font(.callout)
                .bold()
                .fontDesign(.rounded)
            
                .frame(maxWidth: .infinity, alignment: .leading)
            
            GroupBox {
                VStack(alignment: .leading) {
                    HStack(alignment: .center, spacing: .ultraLargeSize) {
              
                        VStack(spacing: .smallSize) {
                            VStack {
                                Text("🏁")
                                    .font(.largeTitle)
                                    .frame(width:120)
                                Text("When It Finished")
                            }
                            .font(.caption)
                            .bold()
                            .fontDesign(.rounded)
                            
                            RadioButton(value: $vm.startTimeMode) { result in
                                vm.startTimeMode = true
                            }
                        }
                        
                        VStack(spacing: .smallSize) {
                            VStack {
                                Text("🚀")
                                    .font(.largeTitle)
                                    .frame(width:120)
                                Text("When to start")

                            }
                            .font(.caption)
                            .bold()
                            .fontDesign(.rounded)
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
                .fontDesign(.rounded)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            TextField(vm.startPlaceholder, text: $vm.standardLabel)
                .font(.title3)
                .bold()
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .frame(height: 55)
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(.smallSize)
            GroupBox {
                DatePicker("",selection: $vm.standardTime, displayedComponents: .hourAndMinute)
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
                .fontDesign(.rounded)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            TextField(vm.calculatedPlaceholder, text: $vm.calculatedLabel)
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
    HabitDetailView(vm: HabitDetailViewModel(habit: Habit.example))
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)

}
