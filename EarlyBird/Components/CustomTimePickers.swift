//
//  CustomTimePickers.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 25/11/2023.
//

import SwiftUI

struct CustomTimePickers: View {
    @Binding var hours: Int
    @Binding var mins: Int
    
    var body: some View {
        HStack {
            VStack {
                Text("Hours")
                    .font(.subheadline)
                    .fontDesign(.rounded)
                    .padding(.horizontal, .largeSize)
                    .foregroundStyle(Color(uiColor: UIColor.systemGray))
                    
                Picker("", selection: $hours){
                    ForEach(0..<24, id: \.self) { i in
                        Text("\(i)").tag(i)
                    }
                }
            }
            VStack {
                Text("Minutes")
                    .font(.subheadline)
                    .fontDesign(.rounded)
                    .padding(.horizontal, .largeSize)
                    .foregroundStyle(Color(uiColor: UIColor.systemGray))
                Picker("", selection: $mins){
                    ForEach(0..<61, id: \.self) { i in
                        Text("\(i)").tag(i)
                    }
                }
            }
        }
        .frame(height: 160)
        .pickerStyle(WheelPickerStyle())
        .cornerRadius(.mediumSize)
    }
}


#Preview {
    CustomTimePickers(hours: .constant(0), mins: .constant(30))
}
