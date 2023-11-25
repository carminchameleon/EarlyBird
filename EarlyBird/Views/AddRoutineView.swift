//
//  AddRoutineView.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 25/11/2023.
//

import SwiftUI

enum DisplayTime: String {
    case hours = "hours"
    case minutes = "min"
    case seconds = "sec"
}

struct AddRoutineView: View {
    @Environment (\.dismiss) var dismiss
    @State var showCustomSelect: Bool = false

    @State var hour: Int = 00
    @State var min: Int = 00 {
        didSet {
            print(min)
        }
    }
    @State var sec: Int = 00
    
    @State var textFieldValue: String = ""
    var body: some View {
        ScrollView {
            VStack(spacing: .superLargeSize) {
                TextField("Add your routine", text: $textFieldValue)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(.white)
                    .cornerRadius(.mediumSize)
                Button("Custom") {
                    withAnimation {
                        showCustomSelect.toggle()
                    }
                }
                // preset
                VStack(alignment: .leading) {
                    Text("Presets")
                    ScrollView {
                        HStack {
                            Text("1 Min")
                        }
                    }
                }.background(.white)
                
                if showCustomSelect {
                    CustomTimePickers(hour: $hour, min: $min, sec: $sec)
                }
                
                
                Button(action: saveButtonTapped, label: {
                    Text("save".uppercased())
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .cornerRadius(.mediumSize)
                })
            }
        }
        .navigationTitle("Add Routine")
        .background(Color(.systemGroupedBackground))
    }
}

// 두글자 이상
// 시간 선택도 해야 함
func saveButtonTapped() {
}




#Preview {
    AddRoutineView()
}
