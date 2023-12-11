//
//  CustomTimePickers.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 25/11/2023.
//

import SwiftUI

struct CustomTimePickers: View {
    @Binding var hour: Int
    @Binding var min: Int
    @Binding var sec: Int
    
    var body: some View {
        HStack {
            VStack {
                Text(Time.hours.rawValue.uppercased())
                    .padding(.horizontal, .largeSize)
                    .foregroundColor(Color.blue)
                Picker("", selection: $hour){
                    ForEach(0..<23, id: \.self) { i in
                        Text("\(i)").tag(i)
                    }
                }
            }
            VStack {
                Text(Time.minutes.rawValue.uppercased())
                    .padding(.horizontal, .largeSize)
                    .foregroundColor(Color.blue)
                Picker("", selection: $min){
                    ForEach(0..<60, id: \.self) { i in
                        Text("\(i)").tag(i)
                    }
                }
            }
            VStack {
                Text(Time.seconds.rawValue.uppercased())
                    .padding(.horizontal, .largeSize)
                    .foregroundColor(Color.blue)
                Picker("", selection: $sec){
                    ForEach(0..<60, id: \.self) { i in
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
    CustomTimePickers(hour: .constant(0), min: .constant(30), sec: .constant(0))
}
