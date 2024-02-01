//
//  PresetList.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 23/12/2023.
//

import SwiftUI

struct PresetList: View {
    @Binding var hours: Int
    
    @Binding var mins: Int
    
    @State var presetList = [
        SelectableTime(type: .minutes, number: 1),
        SelectableTime(type: .minutes, number: 5),
        SelectableTime(type: .minutes, number: 10),
        SelectableTime(type: .minutes, number: 20),
        SelectableTime(type: .minutes, number: 30),
        SelectableTime(type: .minutes, number: 45),
        SelectableTime(type: .hours, number: 1),
        SelectableTime(type: .hours, number: 2),
    ]
    var buttonTapped: () -> Void
    
    var body: some View {
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
                                        .foregroundStyle(Color.theme.accent)
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
    
    func presetButtonTapped(_ item: SelectableTime) {
        switch item.type {
        case .hours:
            hours = item.number
            mins = 0
        case .minutes:
            hours = 0
            mins = item.number
        case .seconds:
            break
        }
        buttonTapped()
        
//        let title = textFieldValue.trimmingCharacters(in: .whitespaces)
//        if title.isEmpty {
//            isShowingAlert.toggle()
//            return
//        }
        // title / duration
    }
    
}

#Preview {
    PresetList(hours: .constant(10), mins: .constant(20)) {
        
    }
}
