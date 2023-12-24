//
//  EditRoutineView.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 17/12/2023.
//

import SwiftUI

class EditRoutineViewModel: ObservableObject {
    @Published var item: Activity?
    
    @Published var textFieldValue: String = ""
    
    @Published var hours: Int = 00
    
    @Published var mins: Int = 00
    
    @Published var isOn = true
    
    var updateActivity: (Activity) -> Void
    
    init(item: Activity?, updateActivity: @escaping ((Activity)-> Void)) {
        self.item = item
        self.textFieldValue = item?.title ?? ""
        self.hours = item?.duration.getTime().hours ?? 0
        self.mins = item?.duration.getTime().minutes ?? 0
        self.isOn = item?.isOn ?? true
        self.updateActivity = updateActivity
    }
    
    func handleSaveButtonTapped() {
        let title = textFieldValue.trimmingCharacters(in: .whitespaces)
        let duration = Double(hours * 3600 + mins * 60)
        item = item?.updateActivity(newTitle: title, newDuration: duration, isOn: isOn)
        if let item = item {
            updateActivity(item)
        }
    }
}

struct EditRoutineView: View {
    @Binding var isShowingSheet: Bool
    
    @State var isShowingAlert: Bool = false
    
    @StateObject var vm: EditRoutineViewModel

    enum FocusedField {
          case title
    }

    @FocusState private var focusedField: FocusedField?

    var body: some View {
        ScrollView {
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
    EditRoutineView(isShowingSheet: .constant(true), vm: EditRoutineViewModel(item: Activity(title: "eat kimch", duration: 120), updateActivity: { _ in
        
    }))
}

