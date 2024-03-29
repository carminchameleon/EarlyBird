//
//  ActionDetailView.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 31/12/2023.
//

import SwiftUI

struct ActionDetailView: View {
    @Binding var isShowingSheet: Bool
    @StateObject var vm: ActionDetailViewModel
    @State private var showAlert: Bool = false
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: .largeSize) {
                TextField("Action Name", text: $vm.textFieldValue)
                    .font(.title3)
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(.mediumSize)
                    
                GroupBox {
                    CustomTimePickers(hours: $vm.hours, mins: $vm.mins)
                }
                
                GroupBox {
                    Toggle(isOn: $vm.isOn, label: {
                        Text("Active")
                            .bold()
                    })
                }
                PresetList(isShowingSheet: $isShowingSheet, isShowingAlert: $showAlert, textFieldValue: $vm.textFieldValue, hours: $vm.hours, mins: $vm.mins) {
                    vm.handleSaveButtonTapped()
                }
            }
            
        }
        .tint(Color.theme.accent)
        .padding()
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
        }
    }
}

//#Preview {
//    ActionDetailView(isShowingSheet: .constant(false), vm: ActionDetailViewModel(item: <#Action?#>, habit: <#Habit#>, updateActivity: <#(Activity) -> Void#>))
//}
