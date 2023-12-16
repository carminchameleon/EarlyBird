//
//  AddRoutineView1.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 6/12/2023.
//

import SwiftUI

struct AddRoutineView: View {
    @Binding var isShowingSheet: Bool
    @State var textFieldValue: String = "" {
        didSet {
            print(textFieldValue)
        }
    }
    
    @State var hour: Int = 00
    @State var min: Int = 00 {
        didSet {
            print(min)
        }
    }

    
    var body: some View {
        ScrollView {
            VStack(spacing: .largeSize) {
                TextField("Routine Name", text: $textFieldValue)
                    .font(.title3)
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(UIColor.secondarySystemFill))
                    .cornerRadius(.mediumSize)
                
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
                    isShowingSheet.toggle()
                }, label: {
                    Text("Done")
                })
                .disabled(true)
            }
        }.tint(.orange)
    }
}

#Preview {
    AddRoutineView(isShowingSheet: .constant(true))
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
