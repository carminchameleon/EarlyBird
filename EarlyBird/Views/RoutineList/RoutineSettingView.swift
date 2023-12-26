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
                    print("Save button tapped")
                }, label: {
                    Text("Save")
                })
            }
        }
    }
    var titleSection: some View {
        GroupBox {
            HStack {
                Image(systemName: "paintbrush.pointed.fill")
                    .overlay {
                        ColorPicker("", selection: $vm.color)
                            .labelsHidden()
                            .opacity(0.015)
                    }
                TextField("Morning, Night, Weekends etc", text: $vm.title)
                    .multilineTextAlignment(.center)
            }
        }
        .frame(height: 55)
        .foregroundColor(vm.color)
        .font(.title2)
        .bold()
        .fontDesign(.rounded)
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
                                    .frame(width:100)
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
                                    .frame(width:100)
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
            
            TextField(vm.startPlaceholder, text: $vm.standardTitle)
                .font(.title3)
                .bold()
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .frame(height: 45)
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
            
            TextField(vm.calculatedPlaceholder, text: $vm.calculatedTitle)
                .font(.title3)
                .bold()
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .frame(height: 45)
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(.mediumSize)
        }
    }
}
#Preview {
    RoutineSettingView(vm: RoutineSettingViewModel())
}


struct RadioButton: View {
    
    @Binding var value: Bool
    var isTapped: (Bool) -> Void
    var body: some View {
        Button {
            isTapped(value)
        } label: {
            Image(systemName: value ? "checkmark.circle.fill" : "circle")
        }
    }
}
