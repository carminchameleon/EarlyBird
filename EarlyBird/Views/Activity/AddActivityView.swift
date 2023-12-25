//
//  AddActivityView1.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 6/12/2023.
//

import SwiftUI

struct AddActivityView: View {
    @Binding var isShowingSheet: Bool
    
    @State var isShowingAlert: Bool = false
    
    @State var textFieldValue: String = ""
    
    @State var hours: Int = 00
    
    @State var mins: Int = 00
    
    @State var presetList = [
        SelectableTime(type: .minutes, number: 1),
        SelectableTime(type: .minutes, number: 2),
        SelectableTime(type: .minutes, number: 3),
        SelectableTime(type: .minutes, number: 4),
        SelectableTime(type: .minutes, number: 5),
        SelectableTime(type: .minutes, number: 10),
        SelectableTime(type: .minutes, number: 15),
        SelectableTime(type: .minutes, number: 20),
        SelectableTime(type: .hours, number: 1),
        SelectableTime(type: .hours, number: 2),
    ]
    
    // 탭 하는 순간에 저장될 수 있게 하기.
    
    enum FocusedField {
          case title
    }
    
    @FocusState private var focusedField: FocusedField?
    
    var addActivity: (Activity) -> Void
    
    var body: some View {
            VStack(spacing: .largeSize) {
                TextField("Routine Name", text: $textFieldValue)
                    .font(.title3)
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(.mediumSize)
//                    .focused($focusedField, equals: .title)
                
                GroupBox {
                    CustomTimePickers(hours: $hours, mins: $mins)
                }
                PresetList(isShowingSheet: $isShowingSheet, isShowingAlert: $isShowingAlert, textFieldValue: $textFieldValue, hours: $hours, mins: $mins, addActivity: addActivity)
                Spacer()
            }
        .padding()
        .navigationTitle("Add Routine")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel") {
                    isShowingSheet.toggle()
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    saveButtonTapped()
                }, label: {
                    Text("Save")
                })
                .disabled(canNotSubmit())
            }
        }
        .alert("Please Set routine name 🪶", isPresented: $isShowingAlert) {
                   Button("OK", role: .cancel) { }
        }
        .tint(.orange)
        .onAppear {
            focusedField = .title
        }

    }
    
    var selectableView: some View {
        VStack {
            Text("Presets")
                .frame(maxWidth: .infinity, alignment: .leading)
                .bold()
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(presetList, id: \.id) { item in
                        Circle()
                            .fill(Color(UIColor.secondarySystemBackground))
                            .frame(width: 80)
                            .overlay {
                                VStack(spacing: -4) {
                                    Text("\(item.number)")
                                        .font(.title)
                                    Text("\(item.type.rawValue)")
                                        .foregroundStyle(.orange)
                                }
                            }
                            .onTapGesture {
                                presetButtonTapped(item)
                            }
                    }
                }
            }
        }
    }
    
    func canNotSubmit() -> Bool {
        let title = textFieldValue.trimmingCharacters(in: .whitespaces)
        return title.count == 0 || (mins == 0 && hours == 00)
    }
    
    func saveButtonTapped() {
        let title = textFieldValue.trimmingCharacters(in: .whitespaces)
        let duration = Double(hours * 3600 + mins * 60)
        let activity = Activity(title: title, duration: duration)
        addActivity(activity)
        isShowingSheet.toggle()
    }
    
    func presetButtonTapped(_ item: SelectableTime) {
        var duration: Double = 0
        switch item.type {
        case .hours:
            duration = Double(item.number) * 3600
            hours = item.number
            mins = 0
        case .minutes:
            duration = Double(item.number) * 60
            hours = 0
            mins = item.number
        case .seconds:
            break
        }
        
        let title = textFieldValue.trimmingCharacters(in: .whitespaces)
        if title.isEmpty {
            isShowingAlert.toggle()
            return
        }
        
        let activity = Activity(title: title, duration: duration)
        addActivity(activity)
        isShowingSheet.toggle()
    }
}

#Preview {
    AddActivityView(isShowingSheet: .constant((TUREAD != 0))) { activity in
        
    }
}
