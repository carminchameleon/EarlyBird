//
//  EditRoutineView.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 17/12/2023.
//

import SwiftUI

struct EditActivityView: View {
    @Binding var isShowingSheet: Bool
    
    @State var isShowingAlert: Bool = false
    
    @StateObject var vm: EditActivityViewModel

    enum FocusedField {
          case title
    }

    @FocusState private var focusedField: FocusedField?

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: .largeSize) {
                TextField("Routine Name", text: $vm.textFieldValue)
                    .font(.title3)
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(.mediumSize)
                    .focused($focusedField, equals: .title)

                GroupBox {
                    CustomTimePickers(hours: $vm.hours, mins: $vm.mins)
                }
                
                GroupBox {
                    Toggle(isOn: $vm.isOn, label: {
                        Text("Active")
                            .bold()
                    })
                }
                PresetList(isShowingSheet: $isShowingSheet, isShowingAlert: $isShowingAlert, textFieldValue: $vm.textFieldValue, hours: $vm.hours, mins: $vm.mins) { _ in
                    vm.handleSaveButtonTapped()
                }
            }
        }
        .padding()
        .navigationTitle("Edit Routine")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel") {
                    isShowingSheet.toggle()
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    vm.handleSaveButtonTapped()
                    isShowingSheet.toggle()
                }, label: {
                    Text("Save")
                })
                .disabled((vm.textFieldValue.count == 0) || (vm.mins == 0 && vm.hours == 00))
            }
        }.tint(.orange)
    }
}

#Preview {
    EditActivityView(isShowingSheet: .constant(true), vm: EditActivityViewModel(item: Activity(title: "eat kimch", duration: 120), updateActivity: { _ in
        
    }))
}

