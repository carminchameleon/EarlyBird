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
            
                Button(action: {
                    withAnimation {
                        showCustomSelect.toggle()
                    }
                }, label: {
                    Text("⏱️ Custom".uppercased())
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.yellow.gradient)
                        .cornerRadius(.mediumSize)
                })
                
                Toggle(isOn: $showCustomSelect, label: {
                    Text("블라블라")
                })
 
                Text(String(min))
                if showCustomSelect {
                    CustomTimePickers(hour: $hour, min: $min, sec: $sec)
                }
                
                
                Button(action: saveButtonTapped, label: {
                    Text("save".uppercased())
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor.gradient)
                        .cornerRadius(.mediumSize)
                })
            }
        }
        .padding()
        .navigationTitle("Add Routine")
        .background(Color(.systemGroupedBackground))
    }
}

// 두글자 이상
// 시간 선택도 해야 함
func saveButtonTapped() {
    print("save button is tapped")
}




#Preview {
    AddRoutineView()
}
