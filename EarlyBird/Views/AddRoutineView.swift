//
//  AddRoutineView1.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 6/12/2023.
//

import SwiftUI

struct AddRoutineView: View {
    @Binding var isShowingSheet: Bool
    
    @State var textFieldValue: String = ""
    
    @State var hour: Int = 00
    
    @State var min: Int = 00
    
    enum FocusedField {
          case title
    }
    
    @FocusState private var focusedField: FocusedField?
    
    var addActivity: (Activity) -> Void
    
    var body: some View {
        ScrollView {
            VStack(spacing: .largeSize) {
                TextField("Routine Name", text: $textFieldValue)
                    .font(.title3)
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(.mediumSize)
                    .focused($focusedField, equals: .title)
                
                GroupBox {
                    CustomTimePickers(hour: $hour, min: $min)
                }
            }
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
        .tint(.orange)
        .onAppear {
            focusedField = .title
        }

    }

    func canNotSubmit() -> Bool {
        let title = textFieldValue.trimmingCharacters(in: .whitespaces)
        return title.count == 0 || (min == 0 && hour == 00)
    }
    
    func saveButtonTapped() {
        let title = textFieldValue.trimmingCharacters(in: .whitespaces)
        let duration = Double(hour * 3600 + min * 60)
        let activity = Activity(title: title, duration: duration)
        addActivity(activity)
        isShowingSheet.toggle()
    }
    
}

#Preview {
    AddRoutineView(isShowingSheet: .constant(true)) { _ in
    }
}



struct CustomDatePicker1: View {
    @Binding var hourSelection: Int
    @Binding var minuteSelection: Int
    
    static private let maxHours = 24
    static private let maxMinutes = 60
    private let hours = [Int](0...Self.maxHours)
    private let minutes = [Int](0...Self.maxMinutes)
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: .zero) {
                Picker(selection: $hourSelection, label: Text("")) {
                    ForEach(hours, id: \.self) { value in
                        Text("\(value) hr")
                            .tag(value)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: geometry.size.width / 2, alignment: .center)
                Picker(selection: $minuteSelection, label: Text("")) {
                    ForEach(minutes, id: \.self) { value in
                        Text("\(value) min")
                            .tag(value)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                .pickerStyle(.wheel)
                .frame(width: geometry.size.width / 2, alignment: .center)
            }
        }
    }
}


struct CustomDatePicker: View {
    @Binding var hourSelection: Int
    @Binding var minuteSelection: Int
    
    static private let maxHours = 23
    static private let maxMinutes = 60
    private let hours = [Int](0...Self.maxHours)
    private let minutes = [Int](0...Self.maxMinutes)
    
    var body: some View {
        GeometryReader { geometry in
            HStack(alignment: .center) {
                Picker(selection: $hourSelection, label: Text("")) {
                    ForEach(hours, id: \.self) { value in
                        Text("\(value)")
                            .tag(value)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: geometry.size.width / 2, alignment: .center)
                .overlay(alignment: .center) {
                    Text("hours")
                        .padding(.leading, 70)
                }

                Picker(selection: $minuteSelection, label: Text("")) {
                    ForEach(minutes, id: \.self) { value in
                        Text("\(value)")
                            .tag(value)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: geometry.size.width / 2, alignment: .center)
                .overlay(alignment: .center) {
                    Text("mins")
                        .padding(.leading, 70)
                }
            }
        }
    }
}
